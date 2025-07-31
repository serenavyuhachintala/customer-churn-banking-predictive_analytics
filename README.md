# Customer Churn Prediction in Banking Sector (R & SPSS)

This project explores customer attrition at a European bank using real-world data. It aims to identify key drivers of churn through exploratory analysis and predictive modeling using R and SPSS.

---

## Project Overview

Customer churn is a key challenge for banking institutions. This project analyses the behavior of over 10,000 customers from SVND Pvt Ltd to identify patterns behind attrition and build models to predict future churners.

---

## Key Business Questions

- What customer characteristics are associated with higher churn risk?
- Which demographics (age, gender, geography) are more likely to leave?
- What product or account features influence churn?
- Can we build a reliable model to predict churn?

---

## Tools & Technologies

- **R (ggplot2, caret, rpart)**
- **SPSS (Logistic Regression Modeling)**
- **Microsoft Excel (pre-processing)**
- **Dataset Source:** [Kaggle – Bank Customer Churn](https://www.kaggle.com/datasets/shubhendra7/customer-churn-prediction)

---

## Exploratory Data Analysis

### Churn by Age
Customers aged **40–50 years** showed the highest likelihood of churn.  
![Age vs Churn] <img width="904" height="494" alt="image" src="https://github.com/user-attachments/assets/01b10716-0b0f-4120-963b-06c90402b1ee" />


### Churn by Gender
Churn rates were slightly higher among **female customers**, but not significantly.  
<img width="618" height="456" alt="image" src="https://github.com/user-attachments/assets/90224f8b-0c83-469f-b484-8a9e4bd833c8" />


### Churn by Geography
Customers in **Germany** had the highest churn rate (~32.4%).  
![Geography vs Churn] <img width="904" height="728" alt="image" src="https://github.com/user-attachments/assets/101194a2-fef0-4aae-a1cb-9541603a4fdf" />


### Number of Products
Churn was highest among customers who held **only one product**.  
<img width="680" height="450" alt="image" src="https://github.com/user-attachments/assets/dd329ac4-9fee-4113-b9d9-a9dc2147dc22" />


### Account Balance
Customers with lower balances churned more often.  
![Balance vs Churn]<img width="904" height="508" alt="image" src="https://github.com/user-attachments/assets/f3e7ee41-374f-4525-9357-96abf74a40bd" />


---

## Predictive Modelling

### Decision Tree Model (R)

- **Accuracy:** 81.5%  
- **Sensitivity (True Positives):** 96%  
- **Specificity (True Negatives):** 30.6%  
- **Important Variables:**  
  - `IsActiveMember`    
  - `Age`     

Model identified clear split conditions like:
- If inactive AND from Germany → High churn risk

![Decision Tree] <img width="904" height="858" alt="image" src="https://github.com/user-attachments/assets/faf7a400-d091-4fe9-997b-f91ffef9c057" />

<img width="392" height="316" alt="image" src="https://github.com/user-attachments/assets/8f8850fd-20e9-4194-9200-b6661fe5b0ee" />


---

### Logistic Regression (SPSS)

- **Accuracy:** 76.1%  
- Significant Predictors:
  - Age (positive correlation)
  - Geography (Germany most risky)
  - Number of Products (fewer = more likely to churn)
  - Active Status (inactive = higher churn)

![Logistic Summary]<img width="688" height="296" alt="image" src="https://github.com/user-attachments/assets/aaedc4d5-3a8c-4403-88c3-0bbdfda525e1" />

<img width="606" height="268" alt="image" src="https://github.com/user-attachments/assets/004db484-7c73-45b7-a0a1-8716921a902a" />
<img width="690" height="272" alt="image" src="https://github.com/user-attachments/assets/6cba80d6-278b-41e6-bf6b-0d5a22f5c117" />

<img width="866" height="404" alt="image" src="https://github.com/user-attachments/assets/71b86d3e-12a0-4675-a099-377e86a619ea" />


---

## Key Takeaways

| Driver                | Churn Impact                  |
|-----------------------|-------------------------------|
| Age 40–50             | High churn risk               |
| Germany               | Highest attrition geography   |
| 1 product only        | Very likely to churn          |
| Inactive status       | Strong churn predictor        |
| Female (slightly)     | Mild increase in churn risk   |

---

## Business Recommendations

1. **Target Retention Campaigns**  
   Focus on German customers aged 40–50 holding only one product.

2. **Product Bundling Strategy**  
   Promote cross-selling to customers with only one product.

3. **Reactivation Offers**  
   Engage inactive members with offers, reminders, and loyalty programs.

4. **Monitor Risk Segments in Real Time**  
   Integrate churn models into CRM for early alerts.

---

## Author

**Serena Vyuha Chintala**  
[GitHub](https://github.com/serenavyuhachintala) | [LinkedIn](https://www.linkedin.com/in/serenavyuhachintala/)



