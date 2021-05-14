#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("DEGs table"),

    # Sidebar with a slider input for number of bins
    sidebarLayout(
        sidebarPanel(
            selectInput(
                inputId = "deg_table",
                label = "DEG table",
                choices = c(
                    "Elderly vs Younger (no correction)"       = "1",
                    "Elderly vs Younger (using sex covariate)" = "2",
                    "Female vs Male (no correction)"           = "3",
                    "Female vs Male (using age covariate)"     = "4",
                    "Female vs Male (Elderly only)"            = "5",
                    "Female vs Male (Younger only)"            = "6",
                    "POS vs NEG (no correction)"               = "7",
                    "POS vs NEG (using age covariate)"         = "8",
                    "POS vs NEG (Elderly only)"                = "9",
                    "POS vs NEG (Younger only)"                = "10"
                ),
                selected = "Elderly vs Younger",
                multiple = F
            ),
        ),

        # Show a plot of the generated distribution
        mainPanel(
            tabsetPanel(
                type = "tabs",
                tabPanel(
                    "DEGs table",
                    DT::dataTableOutput("deg_table_output")
                ),
                tabPanel(
                    "Enrichment analysis",
                    tabsetPanel(
                        tabPanel(
                            "Reactome",
                            downloadButton(outputId = "reactome_download", label = "Download Reactome file (xlsx)"),
                            DT::dataTableOutput("reactome_table_output")
                        ),
                        tabPanel(
                            "BTM",
                            downloadButton(outputId = "btm_download", label = "Download BTM file (xlsx)"),
                            DT::dataTableOutput("btm_table_output")
                        )
                    )
                    # DT::dataTableOutput("enrichment_table_output")
                )
            )
        )
    )
))
