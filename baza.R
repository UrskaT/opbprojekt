library(dplyr)
library(RPostgreSQL)

source("baza/auth.R", encoding='UTF-8')

# Povežemo se z gonilnikom za PostgreSQL
drv <- dbDriver("PostgreSQL")      


# Funkcija za brisanje tabel
# Izbris tabele, če obstaja
delete_table <- function(){
  # Funkcija tryCatch prekine povezavo v primeru napake
  tryCatch({
    # Vzpostavimo povezavo
    conn <- dbConnect(drv, dbname = db, host = host,
                      user = user, password = password)
    # Če tabela obstaja, jo zbrišemo s funkcijo DROP table. 
    # paziti poramo na vrstni red, saj moramo najprej zbrisati tiste, ki se navezujejo na druge
    dbSendQuery(conn, build_sql('DROP TABLE IF EXISTS avto'))
    dbSendQuery(conn, build_sql('DROP TABLE IF EXISTS znamka'))
    dbSendQuery(conn, build_sql('DROP TABLE IF EXISTS pogon'))
    dbSendQuery(conn, build_sql('DROP TABLE IF EXISTS cenovni razred'))
    dbSendQuery(conn, build_sql('DROP TABLE IF EXISTS tip motorja'))
    dbSendQuery(conn, build_sql('DROP TABLE IF EXISTS prestave'))
  }, finally = {
    dbDisconnect(conn)
  })
}

# Funkcija za ustvarjanje tabel
create_table <- function(){

# Uporabimo tryCatch,
# da prisilimo prekinitev povezave v primeru napake
tryCatch({
  # Vzpostavimo povezavo
  conn <- dbConnect(drv, dbname = db, host = host,
                    user = user, password = password)
  
  
  
#Ustvarimo tabelo AVTO
AVTO<- dbSendQuery(conn, build_sql("CREATE TABLE AVTO (
                                        model TEXT PRIMARY KEY,
                                        serija TEXT NOT NULL,
                                        hitrost REAL,
                                        pospesek REAL ,
                                        doseg REAL,
                                        poraba REAL,
                                        emisije REAL)
                                        teza REAL,
                                        dolzina REAL,
                                        slika BLOB NOT NULL)"
  ))

#Ustvarimo tabelo ZNAMKE
ZNAMKE<- dbSendQuery(conn, build_sql("CREATE TABLE ZNAMKE (
                                        znamka TEXT PRIMARY KEY)"
))
  
  
#Ustvarimo tabelo POGON
POGON<- dbSendQuery(conn, build_sql("CREATE TABLE POGON (
                                        opis TEXT PRIMARY KEY,
                                        tip TEXT PRIMARY KEY NOT NULL)"
))

#Ustvarimo tabelo CENOVNI RAZRED
CENOVNI_RAZRED<- dbSendQuery(conn, build_sql("CREATE TABLE CENOVNI RAZRED (
                                        razred INTERVAL PRIMARY KEY,
                                        opis REAL KEY NOT NULL)"
))  

#Ustvarimo tabelo TIP MOTORJA 
TIP_MOTORJA<- dbSendQuery(conn, build_sql("CREATE TABLE TIP MOTORJA (
                                        tip TEXT PRIMARY KEY,
                                        cilindri TEXT,
                                        moč REAL NOT NULL)"
))   
  
  
#Ustvarimo tabelo PRESTAVE
PRESTAVE<- dbSendQuery(conn, build_sql("CREATE TABLE PRESTAVE (
                                        tip TEXT PRIMARY KEY,
                                        stevilo INTEGER NOT NULL)"
))   
  
  
}, finally = {
  # Prekinemo povezavo
  dbDisconnect(conn)
  
})}

  
  
  
  
  
  
  
  
  
 