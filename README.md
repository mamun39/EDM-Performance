# EDM-Performance
This repository contains files to test performance of EDM completion algorithms presented in Dokmanic et al. (Euclidean Distance Matrices: Essential Theory, Algorithms and Applications) in POLA configuration.

## Main functions
(Copied from https://github.com/LCAV/edmbox)

| Filename  | Description |
| ------------- | ------------- |
| edm.m  | Creates an EDM from a list of points  |
| random_deletion_mask.m  | Observation mask with randomly removed distances  |
| rank_complete_edm.m  | EDM completion with rank alternation  |
| alternating_descent.m | S-stress minimization with ACD  |


## Helper functions
(Copied from https://github.com/LCAV/edmbox)

| Filename  | Description |
| ------------- | ------------- |
| cubicfcnroots.m | Roots of a cubic polynomial |
| quadfcn.m | Roots of a quadratic  |

## Testing performance for POLA configuration

| Filename  | Description |
| ------------- | ------------- |
| GetRecoveryError.m  | Runs the EDM completions algorithms with input configurations and returns the distance recovery errors |
| test.m  | Calls GetRecoveryError function with POLA configurations and plots the error |
| guiEDM.mlapp  | GUI version of test.m  |
