#Pectus-cluster
#Total population descriptive statistics
#See the Pectus_cluster data dictionary for variable definitions

#________set working directory and import table_______________________________


raw_data <- read.csv("C:/Users/csuehs/Documents/00-Projects_Montpellier/PECTUS-Cluster/R_pectus_cluster/pectus_cluster_data.csv")


#________qualitative variables: get percentages_______________________

    
qual_vars <- data.frame(raw_data$sex,
                        raw_data$pec_fam,
                        raw_data$psychosocial,
                        raw_data$dyspnea,
                        raw_data$palpit,
                        raw_data$anom_puls)


eff <- function(x) {length(which(!is.na(x)))}

per_func <- function(x) {mean(x, na.rm = TRUE)*100}

count<- sapply(qual_vars, eff)
nums <- sapply(qual_vars, sum, na.rm = TRUE)
percentage_of_1s <- sapply(qual_vars, per_func)

options(scipen = 999)
qual_var_results <- data.frame(count, nums, percentage_of_1s)
write.csv(qual_var_results, file = "C:/Users/csuehs/Dropbox/PECTUS-cluster/total_population_centrality/Table_1a_Totalpop_percentages.csv")
write.csv2(qual_var_results, file = "C:/Users/csuehs/Dropbox/PECTUS-cluster/total_population_centrality/Table_1a_Totalpop_percentages_csv2.csv")

#________quantitative variables: get min, max, mean, sd, median, iqrange________

quant_vars <- data.frame(raw_data$bmi,
                         raw_data$age,
                         raw_data$haller,
                         raw_data$fvc,
                         raw_data$tlc,
                         raw_data$rv.tlc,
                         raw_data$reserve,
                         raw_data$o2_puls,
                         raw_data$vent_threshold,
                         raw_data$vo2max,
                         raw_data$hr_max,
                         raw_data$fev1.fvc,
                         raw_data$frc)

quant_vars$raw_data.fvc <- quant_vars$raw_data.fvc *100
quant_vars$raw_data.tlc <- quant_vars$raw_data.tlc *100

quartile_1 <- function(x) {quantile(x, probs = seq(0,1,0.25), na.rm = TRUE)[2]}
quartile_3 <- function(x) {quantile(x, probs = seq(0,1,0.25), na.rm = TRUE)[4]}
shap <- function(x) {as.numeric(shapiro.test(x)[2])}


count<- sapply(quant_vars, eff)
minimum <- sapply(quant_vars, min, na.rm = TRUE)
maximum <- sapply(quant_vars, max, na.rm = TRUE)
mean <- sapply(quant_vars, mean, na.rm = TRUE)
st_d <- sapply(quant_vars, sd, na.rm = TRUE)
median <- sapply(quant_vars, median, na.rm = TRUE)
quartile_25p <- sapply(quant_vars, quartile_1)
quartile_75p <- sapply(quant_vars, quartile_3)
shapiro_p <- sapply(quant_vars, shap)

options(scipen = 999)
quant_var_results <- data.frame(count, minimum, maximum, mean, 
                     st_d, median, quartile_25p, quartile_75p, shapiro_p)

write.csv(quant_var_results, file = "C:/Users/csuehs/Dropbox/PECTUS-cluster/total_population_centrality/Table_1b_total_population_centrality.csv")
write.csv2(quant_var_results, file = "C:/Users/csuehs/Dropbox/PECTUS-cluster/total_population_centrality/Table_1b_total_population_centrality_csv2.csv")

