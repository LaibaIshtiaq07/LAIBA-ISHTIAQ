str(patient_info)
clean_data<-patient_info
cholestrol_level<-230
if (cholestrol_level > 240) {
  print("High Cholestrol")
}
if (cholestrol_level < 240) {
  print("High Cholestrol")
}
systolic_bp<-130
if (systolic_bp < 120) {
  print("Blood pressure is normal")
} else {
  print("Blood pressure is high")
}
factor_cols <- c("gender", "diagnosis", "smoker")
for (col in factor_cols) {
  clean_data[["gender"]] <- as.factor(clean_data[["gender"]])
}
for (col in factor_cols) {
  clean_data[["diagnosis"]] <- as.factor(clean_data[["diagnosis"]])
}
for (col in factor_cols) {
  clean_data[["smoker"]] <- as.factor(clean_data[["smoker"]])
}
binary_cols <- c("smoker")
for (col in binary_cols) {
  clean_data[["smoker"]] <- ifelse(clean_data[["smoker"]] == "yes", 1, 0)
}
str(clean_data)
str(patient_info)
