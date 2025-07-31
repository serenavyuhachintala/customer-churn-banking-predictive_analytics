# Load required libraries
install.packages("dplyr")
install.packages("tidyr")
install.packages("ggplot2")
install.packages("corrplot")
install.packages("caret")
install.packages("caTools")
install.packages("pROC")

library(dplyr)
library(tidyr)
library(ggplot2)
library(corrplot)
library(caret)
library(caTools)
library(pROC)

# Read the dataset
churn_data <- read.csv("customer_churn.csv")

str(churn_data)

# Check for NA values
any(is.na(churn_data))

# Omit NA values

churn_data <- na.omit(churn_data)

# Check for 0 values in tenure column
any_zero_tenure <- any(churn_data$tenure == 0)

# Delete rows with missing values in tenure column
churn_data <- churn_data[!is.na(churn_data$tenure), ]

# Fill missing values in TotalCharges column with mean
churn_data$TotalCharges <- ifelse(is.na(churn_data$TotalCharges),
                                  mean(churn_data$TotalCharges, na.rm = TRUE),
                                  churn_data$TotalCharges)
str(churn_data)

# check missing values in each row

colSums(is.na(churn_data))

# Plot gender distribution
gender_dist <- churn_data %>%
  group_by(gender) %>%
  summarise(count = n())

gender_dist$percent <- gender_dist$count / sum(gender_dist$count) * 100

ggplot(gender_dist, aes(x = "", y = count, fill = gender)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(fill = "Gender", title = "Gender Distribution") +
  theme_void() +
  geom_text(aes(label = paste0(round(percent), "%")), position = position_stack(vjust = 0.5))

# Plot churn distribution
churn_dist <- churn_data %>%
  group_by(Churn) %>%
  summarise(count = n())

churn_dist$percent <- churn_dist$count / sum(churn_dist$count) * 100

ggplot(churn_dist, aes(x = "", y = count, fill = Churn)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(fill = "Churn", title = "Churn Distribution") +
  theme_void() +
  geom_text(aes(label = paste0(round(percent), "%")), position = position_stack(vjust = 0.5))

# Load required libraries
library(dplyr)


# Count churn by gender
table(churn_data$gender, churn_data$Churn)



# Calculate churn count by gender
churn_gender <- churn_data %>%
  group_by(gender, Churn) %>%
  summarise(count = n())

# Plot churn distribution with respect to gender
ggplot(churn_gender, aes(x = gender, y = count, fill = Churn)) +
  geom_bar(stat = "identity") +
  labs(x = "Gender", y = "Count", title = "Churn Distribution by Gender") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = No", "Churn = Yes")) +
  theme_minimal()


#plot for customer contract dist

contract_dist <- churn_data %>%
  group_by(Contract, Churn) %>%
  summarise(count = n())

contract_dist <- contract_dist %>%
  group_by(Contract) %>%
  mutate(percentage = count / sum(count) * 100)

# Plot contract distribution with respect to churn
ggplot(contract_dist, aes(x = Contract, y = count, fill = Churn)) +
  geom_bar(stat = "identity", position = "dodge") +
  geom_text(aes(label = paste0(round(percentage), "%")), 
            position = position_dodge(width = 0.9), 
            vjust = -0.5, color = "black", size = 3) +
  labs(x = "Contract", y = "Count", title = "Customer Contract Distribution by Churn") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("No Churn", "Churn")) +
  theme_minimal()

#plot for payment method distribution

payment_distribution <- churn_data %>%
  group_by(PaymentMethod) %>%
  summarise(count = n())

payment_distribution <- payment_distribution %>%
  mutate(percentage = count / sum(count) * 100)

# Plot payment method distribution with percentages on bars
ggplot(payment_distribution, aes(x = PaymentMethod, y = count, fill = PaymentMethod)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = paste0(round(percentage), "%")), 
            vjust = -0.5, color = "black", size = 3) +
  labs(x = "Payment Method", y = "Count", title = "Payment Method Distribution") +
  scale_fill_discrete(name = "Payment Method") +
  theme_minimal()


# Create the churn count table by internet service
table(churn_data$InternetService, churn_data$Churn)

# Create the churn count table by gender and internet service
table(churn_data$gender, churn_data$InternetService, churn_data$Churn)


# Plot churn distribution with respect to gender and internet service
gender_internet <- churn_data %>%
  group_by(gender, InternetService, Churn) %>%
  summarise(count = n())

# Calculate percentages
gender_internet <- gender_internet %>%
  group_by(gender, InternetService) %>%
  mutate(percentage = count / sum(count) * 100)

# Plot churn distribution with respect to gender and internet service
ggplot(gender_internet, aes(x = gender, y = count, fill = Churn)) +
  geom_bar(stat = "identity", position = "fill") +
  geom_text(aes(label = paste0(round(percentage), "%")),
            position = position_fill(vjust = 0.5),
            color = "black", size = 3) +
  facet_wrap(~ InternetService) +
  labs(x = "Gender", y = "Count", title = "Churn Distribution by Gender and Internet Service") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = No", "Churn = Yes")) +
  theme_minimal()

#churn distribution with respect to dependents
churn_dependents <- churn_data %>%
  group_by(Dependents, Churn) %>%
  summarise(count = n())

# Plot churn distribution with respect to dependents
ggplot(churn_dependents, aes(x = Dependents, y = count, fill = Churn)) +
  geom_bar(stat = "identity") +
  labs(x = "Dependents", y = "Count", title = "Churn Distribution by Dependents") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = No", "Churn = Yes")) +
  theme_minimal()

#churn distribution with respect to partners
churn_partners <- churn_data %>%
  group_by(Partner, Churn) %>%
  summarise(count = n())

# Plot churn distribution with respect to partners
ggplot(churn_partners, aes(x = Partner, y = count, fill = Churn, label = count)) +
  geom_bar(stat = "identity") +
  geom_text(position = position_stack(vjust = 0.5)) +
  labs(x = "Partner", y = "Count", title = "Churn Distribution by Partners") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn =  No", "Churn = Yes")) +
  theme_minimal()

# Plot churn distribution with respect to senior citizen
churn_sc <- churn_data %>%
  group_by(SeniorCitizen, Churn) %>%
  summarise(count = n())

# Plot churn distribution with respect to senior citizens
ggplot(churn_sc, aes(x = SeniorCitizen, y = count, fill = Churn)) +
  geom_bar(stat = "identity") +
  labs(x = "Senior Citizen", y = "Count", title = "Churn Distribution by Senior Citizens") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = No", "Churn = Yes")) +
  theme_minimal()

# Plot churn distribution with respect to online security
churn_OS <- churn_data %>%
  group_by(OnlineSecurity, Churn) %>%
  summarise(count = n())

# Plot churn distribution with respect to online security
ggplot(churn_OS, aes(x = OnlineSecurity, y = count, fill = Churn)) +
  geom_bar(stat = "identity") +
  labs(x = "Online Security", y = "Count", title = "Churn Distribution by Online Security") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = No", "Churn = Yes")) +
  theme_minimal()

# Plot churn distribution with respect to tech support
churn_tech <- churn_data %>%
  group_by(TechSupport, Churn) %>%
  summarise(count = n())


ggplot(churn_tech, aes(x = TechSupport, y = count, fill = Churn)) +
  geom_bar(stat = "identity") +
  labs(x = "Tech Support", y = "Count", title = "Churn Distribution by Tech Support") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = No", "Churn = Yes")) +
  theme_minimal()

# Plot churn distribution with respect to phone service
churn_phone <- churn_data %>%
  group_by(PhoneService, Churn) %>%
  summarise(count = n())

# Plot churn distribution with respect to phone service
ggplot(churn_phone, aes(x = PhoneService, y = count, fill = Churn)) +
  geom_bar(stat = "identity") +
  labs(x = "Phone Service", y = "Count", title = "Churn Distribution by Phone Service") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = no", "Churn = yes")) +
  theme_minimal()

#filtering churn with yes and no
churn_yes <- churn_data %>% filter(Churn == "Yes")
churn_no <- churn_data %>% filter(Churn == "No")

# Plot the density distribution of monthly charges
ggplot() +
  geom_density(data = churn_yes, aes(x = MonthlyCharges, fill = "Churn"), alpha = 0.5) +
  geom_density(data = churn_no, aes(x = MonthlyCharges, fill = "No Churn"), alpha = 0.5) +
  labs(x = "Monthly Charges", y = "Density", title = "Distribution of Monthly Charges by Churn") +
  scale_fill_manual(values = c("#FF0000", "#00FF00"), labels = c("Churn = yes", "Churn = no")) +
  theme_minimal()


# Plot the density distribution of total charges
ggplot() +
  geom_density(data = churn_yes, aes(x = TotalCharges), fill = "red", alpha = 0.5) +
  geom_density(data = churn_no, aes(x = TotalCharges), fill = "green", alpha = 0.5) +
  labs(x = "Total Charges", y = "Density", title = "Distribution of Total Charges by Churn") +
  scale_fill_manual(values = c("red", "green"), labels = c("Churn = yes", "Churn = no")) +
  theme_minimal()

#tenure vs churn
ggplot(churn_data, aes(x = Churn, y = tenure, fill = Churn)) +
  geom_boxplot() +
  labs(x = "Churn", y = "Tenure", title = "Tenure vs. Churn") +
  scale_fill_manual(values = c("#00FF00", "#FF0000"), labels = c("Churn = no", "Churn = yes")) +
  theme_minimal()

numeric_data <- churn_data %>%
  mutate_if(is.character, as.factor) %>%
  mutate_if(is.factor, as.numeric) %>%
  select_if(is.numeric)

# Calculate the correlation matrix
cor_matrix <- cor(numeric_data)

# Create the correlation plot
corrplot(cor_matrix, method = "color", type = "upper", tl.col = "black", tl.srt = 45, tl.cex = 0.4)


# Preprocess the data
churn_data1 <- churn_data %>%
  select(-customerID) %>%
  mutate_if(is.character, as.factor)

# Split the data into train and test sets
set.seed(123)
train_indices <- createDataPartition(churn_data1$Churn, p = 0.7, list = FALSE)
train_data <- churn_data1[train_indices, ]
test_data <- churn_data1[-train_indices, ]

# Perform logistic regression
model <- glm(Churn ~ ., data = train_data, family = "binomial")

# Assume you have a trained logistic regression model named "model"
# Assume you have a new dataset named "new_data" on which you want to make predictions

# Make predictions on new data
predictions <- predict(model, newdata = test_data, type = "response")

# Convert probabilities to binary predictions
binary_predictions <- ifelse(predictions > 0.5, "Yes", "No")

# Print the predictions
print(binary_predictions)


# Calculate accuracy
accuracy <- sum(binary_predictions == test_data$Churn) / nrow(test_data)

# Print accuracy
print(paste("Accuracy:", accuracy))

# Create confusion matrix
confusion <- table(Actual = test_data$Churn, Predicted = binary_predictions)
print(confusion)

write.csv(churn_data, file = "modified_data.csv", row.names = FALSE)

# Load required libraries
library(caTools)
library(pROC)

# Assume you have the training data named "train_data" and test data named "test_data"

# Fit logistic regression model
model <- glm(Churn ~ ., data = train_data, family = "binomial")

# Make predictions on test data
predictions <- predict(model, newdata = test_data, type = "response")

# Convert probabilities to binary predictions
binary_predictions <- ifelse(predictions > 0.5, "Yes", "No")

# Print the predictions
print(binary_predictions)

# Calculate and print the accuracy
accuracy <- sum(binary_predictions == test_data$Churn) / nrow(test_data)
print(paste("Accuracy:", accuracy))

# Calculate and print the AUC
roc <- roc(test_data$Churn, predictions)
auc <- auc(roc)
print(paste("AUC:", auc))

# Create and print the confusion matrix
confusion <- table(Actual = test_data$Churn, Predicted = binary_predictions)
print(confusion)
