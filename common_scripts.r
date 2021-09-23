library(tidyverse)
library(kableExtra)
library(data.table)
library(ggplot2)
library(cluster) #Библиотека для каластерного анализа
library(captioner) #Библиотка для нумерации таблиц и рисунков и вообще всего
library(treemap) #Библиотека для площадных диаграмм
library(RColorBrewer) #Пакет для цветовых схем для диаграмм
#library(readxl) экспериментировал с импотром из экселя
library(DT) #экспериментировал с datatable
#library(htmltools) экспериментировал с datatable


# Функция вывода таблицы с помощью библиотеки DT, 
get_dt = function(top_data, col_names = c("Федеральный округ" = "FO_name", "Субъект федерации" = "Subj_Name", "Срез показателя" = "Col_num"), output_file_name) {
  datatable(top_data, colnames = col_names, extensions = 'Buttons',
            escape = FALSE,
            rownames = FALSE,
            filter = 'top',
            options = list(searching = TRUE,
                           pageLength = 10,
                           lengthMenu = c(8, 10, 85, 100),
                           dom = 'Bfrtip',
                           buttons = 
                             list('colvis', list(
                               extend = 'collection',
                               buttons = list(list(extend='csv',
                                                   filename = output_file_name),
                                              list(extend='excel',
                                                   filename = output_file_name),
                                              list(extend='pdf',
                                                   filename= output_file_name)),
                               text = 'Download'
                             )),
                           scrollX = TRUE,
                           pageLength = nrow(top_data))) 
}


#Функция для импорта данных из csv файлов в переменные R (требует имя файла в кавычках и берет из каталока data рабочей директории проекта)
import_table = function(file_name){
  read_delim(paste0("data/", file_name), ";", 
             escape_double = FALSE, locale = locale(decimal_mark = ",", 
                                                    grouping_mark = "", encoding = "WINDOWS-1251"), 
             trim_ws = TRUE)
}