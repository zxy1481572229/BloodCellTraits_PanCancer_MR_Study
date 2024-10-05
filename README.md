# BloodCellTraits_PanCancer_MR_Study
In this study, the uploaded code file is designed to perform two-sample Mendelian Randomization (MR) analysis to investigate the risk of cancer across 36 human blood cell traits.

### `mendelian randomization analysis.R`:
This R code is designed to automate the processing of different cancer outcome data and integrate them with the exposure data from blood cell traits. The code is divided into several parts:

- First, it reads the exposure data and processes each cancer outcome file in `.gz` format.
- It then conducts MR analysis, calculating causal effects (including OR values, heterogeneity analysis, and pleiotropy tests).
- Finally, the results of each analysis, including MR results, heterogeneity analysis, and pleiotropy test results, are output and saved as CSV files for further analysis and interpretation.

The core objective of this code is to integrate the data on various cancer types with the blood cell trait exposure data and explore potential causal relationships through MR analysis.

### Citation:
When using these codes in publications, please remember to cite the following article: **Liang J, Zhou X, Lin Y.** *Prospective Study on the Association Between 36 Human Blood Cell Traits and Pan-Cancer Outcomes: A Mendelian Randomization Analysis.*
