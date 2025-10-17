if (!requireNamespace("BiocManager", quietly = TRUE)) 
  install.packages("BiocManager")

# Install Bioconductor packages
BiocManager::install(c("GEOquery","affy","arrayQualityMetrics"))

# Install CRAN packages for data manipulation
install.packages("dplyr")

# Load Required Libraries
library(GEOquery)             
library(affy)                 
library(arrayQualityMetrics)  
library(dplyr)
gse_data <- getGEO("GSE79973", GSEMatrix = TRUE)


expression_data <- exprs(gse_data$GSE79973_series_matrix.txt.gz)

feature_data <-  fData(gse_data$GSE79973_series_matrix.txt.gz)

phenotype_data <-  pData(gse_data$GSE79973_series_matrix.txt.gz)
sum(is.na(phenotype_data$source_name_ch1)) 
raw_data <- ReadAffy(celfile.path = "Raw_Data/CEL_Files")
arrayQualityMetrics(expressionset = raw_data,
                    outdir = "Results/QC_Raw_Data",
                    force = TRUE,
                    do.logtransform = TRUE)
normalized_data <- rma(raw_data)
arrayQualityMetrics(
  expressionset = normalized_data,
  outdir = "Results/QC_Normalized_Data",
  force = TRUE
)
warnings()
arrayQualityMetrics(
  expressionset = normalized_data,
  outdir = "Results/QC_Normalized_Data",
  force = TRUE
)

arrayQualityMetrics(expressionset = normalized_data[,c(1,8,9,11,20)],
                    outdir = "Results/QC_Normalized_Data",
                    force = TRUE)
processed_data <- as.data.frame(exprs(normalized_data))

dim(processed_data)
row_median <- rowMedians(as.matrix(processed_data))

hist(row_median,
     breaks = 100,
     freq = FALSE,
     main = "Median Intensity Distribution")
hist(rnorm(100))
dev.cur()
windows()
hist(row_median,
     breaks = 100,
     freq = FALSE,
     main = "Median Intensity Distribution",
     xlab = "Median Expression",
     ylab = "Density")
threshold <- 3.5 
abline(v = threshold, col = "black", lwd = 2) 

# Select probes above threshold
indx <- row_median > threshold 
filtered_data <- processed_data[indx, ] 
colnames(filtered_data) <- rownames(phenotype_data) 

processed_data <- filtered_data 
class(phenotype_data$source_name_ch1) 

# Define experimental groups (normal vs cancer)
groups <- factor(phenotype_data$source_name_ch1,
                 levels = c("gastric mucosa", "gastric adenocarcinoma"),
                 label = c("normal", "cancer"))

class(groups)
levels(groups)
