str(Metadata)
#copy file of metadata
raw_data<-Metadata
#If statement to check cholesterol level is greater than 240
cholestrol<-230
if(cholestrol>240){
  print("High Cholestrol")
}
if(cholestrol>240){
  print("High Cholestrol")
}else {
  print("LOw Cholestrol")
}
#if…else statement to check if blood pressure is normal.
systolic_bp1<-130
if(systolic_bp1<120){
  print("Blood Pressure is normal")
}else{
  print("Blood Pressure is High")
}
if(systolic_bp1>120){
  print("Blood Pressure is normal")
}else{
  print("Blood Pressure is High")
}
#a for loop to convert all the columns in factor_cols to factor type.
factor_col<-c("height,gender")
for (col in factor_col) {
  raw_data[["height"]] <- as.factor(raw_data[["height"]])
}
for (col in factor_col) {
  raw_data[["gender"]] <- as.factor(raw_data[["gender"]])
}
#Converting Factors to Numeric Codes
binary_col1<-c("gender")
for (col in binary_col1) {
  raw_data[["gender"]] <- ifelse(raw_data[["gender"]] == "Male", 1,0)
}
str(raw_data)
str(Metadata)
