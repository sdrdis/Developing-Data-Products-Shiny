library(UsingR)
library(ggplot2)

# When will you become financially independent
# Using investments



shinyServer(
        function(input, output) {
                output$savings_histogram <- renderPlot({
                        input$resimulate
                        
                        salaries <- matrix(input$initial_salary, input$simulation_length, 1)
                        revenue_from_savings <- matrix(0, input$simulation_length, 1)
                        savings  <- matrix(input$initial_savings, input$simulation_length, 1)
                        financially_independent = -1 # expense rate
                        savings_revenue_superior_to_salary = -1
                        for (i in 1:input$simulation_length) {
                                salaries[i,1] = input$initial_salary * (1.0 + (input$estimated_raise_per_year / 100.0)) ^ (i - 1)
                                salaries[i,1] = salaries[i,1] * rnorm(1, mean=1, sd=(input$salary_variance/100.0))
                                if (i > 1) {
                                        this_year_return_rate <- rnorm(1, mean= (input$investment_returns / 100.0), sd=(input$investment_returns_variance/100.0))
                                        revenue_from_savings[i, 1] = savings[i - 1] * this_year_return_rate
                                        if (revenue_from_savings[i, 1] > salaries[i,1] && savings_revenue_superior_to_salary == -1) {
                                                savings_revenue_superior_to_salary = i
                                        }
                                        if ((revenue_from_savings[i, 1] > salaries[i - 1, 1] * (100.0 - input$salary_saving_rate) / 100.0) && financially_independent == -1) {
                                                financially_independent = i
                                        }
                                        
                                        savings[i, 1] = savings[i - 1] + revenue_from_savings[i, 1] + salaries[i - 1, 1] * input$salary_saving_rate / 100.0
                                }
                        }
                        
                        salaries <- data.frame(year=1:input$simulation_length, value=salaries)
                        savings <- data.frame(year=1:input$simulation_length, value=savings)
                        revenue_from_savings <- data.frame(year=1:input$simulation_length, value=revenue_from_savings)
                        p <- ggplot() + 
                                geom_line(data = salaries, aes(x = year, y = value, color = "Salary")) +
                                geom_line(data = savings, aes(x = year, y = value, color = "Savings"))  +
                                geom_line(data = revenue_from_savings, aes(x = year, y = value, color = "Returns"))  +
                                xlab('Year') +
                                ylab('Money') +
                                labs(color="Legend")
                        if (financially_independent > -1) {
                                p <- p + geom_vline(xintercept = financially_independent, linetype = "longdash")
                        }
                        if (savings_revenue_superior_to_salary > -1) {
                                p <- p + geom_vline(xintercept = savings_revenue_superior_to_salary)
                        }
                        print (p)
                })
                
        }
)