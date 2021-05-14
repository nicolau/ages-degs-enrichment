#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    loadDEGTable <- function() {
        if(input$deg_table == "1") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "Elderly_vs_Younger_only.tsv"))
        } else if(input$deg_table == "2") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "Elderly_vs_Younger_sex_covariate.tsv"))
        } else if(input$deg_table == "3") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "Female_vs_Male_all_samples.tsv"))
        } else if(input$deg_table == "4") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "Female_vs_Male_using_age_covariate.tsv"))
        } else if(input$deg_table == "5") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "Female_vs_Male_Elderly_only.tsv"))
        } else if(input$deg_table == "6") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "Female_vs_Male_Younger_only.tsv"))
        } else if(input$deg_table == "7") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "POS_vs_NEG_all_samples.tsv"))
        } else if(input$deg_table == "8") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "POS_vs_NEG_using_age_covariate.tsv"))
        } else if(input$deg_table == "9") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "POS_vs_NEG_Elderly_only.tsv"))
        } else if(input$deg_table == "10") {
            data <- rio::import(here::here("shinyApp/DEGs_table/data/degs", "POS_vs_NEG_Younger_only.tsv"))
        } else {
            return(NULL)
        }
        data %>%
            as_tibble() %>%
            dplyr::select(-DEG_1, -DEG_5, -DEG_10)
    }
    
    loadGSEATable <- function(db = c("Reactome", "BTM")) {
        if(db == "Reactome") {
            if(input$deg_table == "1") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_Elderly_vs_Younger_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "2") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_Elderly_vs_Younger_sex_covariate_FDR_0.05.tsv"))
            } else if(input$deg_table == "3") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_Female_vs_Male_all_samples_FDR_0.05.tsv"))
            } else if(input$deg_table == "4") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_Female_vs_Male_using_age_covariate_FDR_0.05.tsv"))
            } else if(input$deg_table == "5") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_Female_vs_Male_Elderly_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "6") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_Female_vs_Male_Younger_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "7") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_POS_vs_NEG_all_samples_FDR_0.05.tsv"))
            } else if(input$deg_table == "8") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_POS_vs_NEG_using_age_covariate_FDR_0.05.tsv"))
            } else if(input$deg_table == "9") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_POS_vs_NEG_Elderly_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "10") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_ReactomePathwaysLevel3_POS_vs_NEG_Younger_only_FDR_0.05.tsv"))
            } else {
                return(NULL)
            }
        } else if(db == "BTM") {
            if(input$deg_table == "1") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_Elderly_vs_Younger_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "2") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_Elderly_vs_Younger_sex_covariate_FDR_0.05.tsv"))
            } else if(input$deg_table == "3") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_Female_vs_Male_all_samples_FDR_0.05.tsv"))
            } else if(input$deg_table == "4") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_Female_vs_Male_using_age_covariate_FDR_0.05.tsv"))
            } else if(input$deg_table == "5") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_Female_vs_Male_Elderly_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "6") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_Female_vs_Male_Younger_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "7") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_POS_vs_NEG_all_samples_FDR_0.05.tsv"))
            } else if(input$deg_table == "8") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_POS_vs_NEG_using_age_covariate_FDR_0.05.tsv"))
            } else if(input$deg_table == "9") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_POS_vs_NEG_Elderly_only_FDR_0.05.tsv"))
            } else if(input$deg_table == "10") {
                data <- rio::import(here::here("shinyApp/DEGs_table/data/gsea", "enriched_pathways_BTM_for_GSEA_20131008_POS_vs_NEG_Younger_only_FDR_0.05.tsv"))
            } else {
                return(NULL)
            }
        }
        data %>%
            as_tibble() %>%
            dplyr::select(-leadingEdge)
    }
    
    output$deg_table_output <- DT::renderDT(
        DT::datatable(
            loadDEGTable(),
            rownames = F
        ) %>% DT::formatStyle(
            "logFC",
            backgroundColor = DT::styleInterval(c(-1, 1), c('green', 'white', 'red'))
        ) %>% DT::formatStyle(
            "PValue",
            backgroundColor = DT::styleInterval(c(0.05), c('yellow', 'white'))
        ) %>% DT::formatStyle(
            "FDR",
            backgroundColor = DT::styleInterval(c(0.05), c('yellow', 'white'))
        ) %>% DT::formatRound(2:4, digits = 3)
    )
    
    output$reactome_table_output <- DT::renderDT(
        DT::datatable(
            loadGSEATable(db = "Reactome"),
            rownames = F
        )
    )
    
    output$btm_table_output <- DT::renderDT(
        DT::datatable(
            loadGSEATable(db = "BTM"),
            rownames = F
        )
    )
    
    output$reactome_download <- downloadHandler(
        filename = function() { "enrichment_pathway.xlsx" },
        content = function(file) { xlsx::write.xlsx(loadGSEATable(db = "Reactome"), path = file)}
    )
    
    output$btm_download <- downloadHandler(
        filename = function() { "enrichment_pathway.xlsx" },
        content = function(file) { xlsx::write.xlsx(loadGSEATable(db = "BTM"), path = file)}
    )

})
