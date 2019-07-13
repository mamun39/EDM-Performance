function [DELTA] = GetRecoveryError(n,d,scale,n_del,m_error,n_config,algorithm,errorType)
    
    DELTA = zeros(numel(n_del), numel(m_error));
    
    I = logical(eye(n));

    if strcmp(errorType,'Meters') 
            m_error = m_error/(scale*sqrt(2)); % scaling distance value between (0,1). 
                                               % See https://math.stackexchange.com/questions/3288302/re-scaling-the-outputs-of-a-matrix-completion-algorithm
                                               % for explanation
    end

    for i_err = 1:numel(m_error)
        for i_del = 1:numel(n_del)
            err_in = zeros(4, 1);
            for i_config = 1:n_config

                fprintf('measurement error: %14.6e, # of deletions: %d, config #: %d \n', m_error(i_err), n_del(i_del), i_config);
                X = 0 + (scale-0)*rand(d, n); % point set in coordinates [0,scale]×[0,scale]
                % create new coordinate system with corresponding set [0,1/sqrt(2)]×[0,1/sqrt(2)]
                X = X/(scale*sqrt(2));
                D = edm(X, X);       % create EDM

                % apply distance measurement error
                if strcmp(errorType,'Meters') 
                    temp = sqrt(D) + m_error(i_err)*rand(n); % random error ranging from 0 to m_error(i_err)
                else 
                    temp = sqrt(D) + sqrt(D)*m_error(i_err)*0.01;
                end
                DN = temp.^2;
                DN(I) = 0; % DN is an EDM with distance measurement error

                % randomly delete entries from the EDM
                W = random_deletion_mask(n, n_del(i_del));
                DNM = DN;
                DNM(~W) = 0; % DNM is an EDM with distance measurement error and with randomly deleted entries


                if strcmp(algorithm,'Rank Alteration') 
                    % apply RankCompleteEDM
                    E = rank_complete_edm(DNM, W, d, 0);
                elseif strcmp(algorithm,'Alternating Descent')    
                    % apply Alternating Descent
                    [~, E] = alternating_descent(DN .* W, d);
                else
                    msg = 'Algorithm not defined';
                    error(msg);
                    
                end

                dif = abs(sqrt(E) - sqrt(D));
                dif(W) = 0; 
                %errMax = errMax + max(dif(:)); % measure maximum error among missing entries
                if nnz(dif) > 0
                    err_in(2) = err_in(2) + nanmean(nonzeros(dif));
                end
            end 
            DELTA(i_del, i_err) = err_in(2);
        end
    end
    DELTA = (DELTA / n_config);
    
    % convert the distances back to original coordinate system
    DELTA = (DELTA*scale*sqrt(2));
end
