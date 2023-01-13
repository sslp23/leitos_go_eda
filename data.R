install.packages("remotes")
remotes::install_github("rfsaldanha/microdatasus")

library(microdatasus)
dados <- microdatasus::fetch_datasus(year_start = 2020, month_start= 1, year_end = 2023, month_end = 1, uf = "GO", information_system = "CNES-LT")
dados <- microdatasus::process_cnes(dados)
dados


anos <- c(2017, 2018, 2019, 2020, 2021, 2022)

meses <- 1:12

data <- NA

for(ano in anos){
  for(mes in meses){
    dados <- microdatasus::fetch_datasus(year_start = ano, month_start= mes, year_end = ano, month_end = mes, uf = "GO", information_system = "CNES-LT")
    dados <- microdatasus::process_cnes(dados)
    
    n_rows <- nrow(dados)
    dados <- cbind(dados, mes)
    dados <- cbind(dados, ano)
    data <- rbind(data, dados)
    print(n_rows)
    print(mes)
  }
}

write.csv(data, "Documentos/data_covid/datasus.csv", row.names=FALSE)
