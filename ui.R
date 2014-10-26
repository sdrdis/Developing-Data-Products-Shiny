shinyUI(pageWithSidebar(
        headerPanel("When will you become financially independent?"),
        sidebarPanel(
                # Salary
                # Salary saving rate
                # Investment rate
                # Return saving rate
                numericInput('initial_salary', 'Initial salary (per year)', value=40000),
                sliderInput('estimated_raise_per_year', 'Estimated raise per year (%)', value = 2, min = 0, max = 10, step = 0.1,),
                sliderInput('salary_variance', 'Salary variance (in %, e.g. unemployement periods)', value = 0, min = 0, max = 50, step = 0.5,),
                numericInput('initial_savings', 'Initial savings', value=0),
                sliderInput('salary_saving_rate', 'Saving rate on salary (%)', value = 5, min = 0, max = 100, step = 0.5,),
                sliderInput('investment_returns', 'Investment returns (%, ~ 11% for S&P500)', value = 6, min = 0, max = 40, step = 0.1,),
                sliderInput('investment_returns_variance', 'Investment returns variance (in %, ~ 18% for S&P500)', value = 0, min = 0, max = 50, step = 0.5,),
                sliderInput('simulation_length', 'Simulation length (years)', value = 20, min = 1, max = 80, step = 1,),
                actionButton('resimulate', 'Resimulate')
        ),
        mainPanel(
                div('Financial independence is generally used to describe the state of having sufficient personal wealth to live, without having to work actively for basic necessities. [Financial Independence, Wikipedia]'),
                plotOutput('savings_histogram'),
                div('The dashed line, if it appears, represent the first time your savings returns are more important than your expenses ; this is a good sign, you are near financial independence.'),
                div('The full line, if it appears, represent the first time your savings returns are more important than your salary.'),
                div('When using salary and / or investment return variance, click on the Resimulate button several times to get an idea of possible scenarios.'),
                div('As you can see, achieving financial independence is not an easy task, but possible if you are willing to make some short term sacrifices.')
        )
))
