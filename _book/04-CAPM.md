# CAPITAL ASSET PRICING MODEL (CAPM)

## El problema

Una vez que hemos establecido la manera en la que se pueden estimar algunos valores --como las regresiones lineales y el método de máxima verosimilitud--, además de la naturaleza de los retornos de algunos activos en el capítulo 4, es posible comenzar a hablar de maneras en la que se pueden estimar los valores futuros de los rendimientos de activos y --de esta manera-- poder tomar mejores decisiones de inversiones. Por ello, hablaremos del modelo de **Capital Asset Pricing Model**. El modelo es muy sencillo y pretende estimar su rentabilidad esperada en función del **riesgo sistemático**. Por lo mismo, en este modelo se utilizan los valores de los precios de los activos a lo largo del tiempo y utiliza la intuición con la que derivamos la ecuación lineal con los Mínimos cuadrados ordinarios (MCO).

```{=tex}
\begin{equation}
    R_{jt}-R{ft}=\alpha_{j}+\beta_j(R_{mt}-R_{ft})+u_{jt}
(\#eq:CAMP)
\end{equation}
```
En la ecuación \@ref(eq:CAMP)

-   $R_{jt}$ es el retorno del portafolio $j$ en el tiempo $t$

-   $R_{ft}$ es el retorno de un bono sin riesgo gubernamental en un año. **Parecido a los CETES**.

-   $R_{mt}$ es el retorno en un portafolio de mercado.

-   $u_{jt}$ es el retorno en un portafolio de mercado.

-   $\alpha_{j},\beta_j$ son los coeficientes que queremos obtener.

De esta manera, $\alpha_j$ es el coeficiente que más nos interesa debido a que queremos ver si el activo supera o no el index del mercado con base en el activo fijo.

Si $\alpha_j$ es positivo entonces sabemos que el retorno tiene buenos rendimiendtos y uno negativo significa que no. Por tanto $H_0:\alpha_j=0$

## Estimación R

Para la estimación utilizaremos el paquete "BatchGetSymbols". Este paquete nos permitirá descargar información acerca de la bolsa de valores internacional.

## ESTIMACIÓN

### Dependencias


```r
#install.packages("pacman")
#pacman nos permite cargar varias librerias en una sola línea
library(pacman)
pacman::p_load(tidyverse,BatchGetSymbols,ggplot2,lubridate,readxl,tidyquant)
```

### Descarga de los valores


```r
#Primero determinamos el lapso de tiempo
pd<-as.Date("2021/09/18") #primer fecha
pd
#> [1] "2021-09-18"
ld<-as.Date("2022/09/18") #última fecha
ld
#> [1] "2022-09-18"
#Intervalos de tiempo
int<-"monthly"
#Datos a elegir
dt<-c("AMZN")
dt2<-c("TSLA")
#Descargando los valores
?BatchGetSymbols()
data1<- BatchGetSymbols(tickers = dt,
                       first.date = pd,
                       last.date = ld,
                       freq.data = int,
                       do.cache = FALSE,
                       thresh.bad.data = 0)
data2<- BatchGetSymbols(tickers = dt2,
                       first.date = pd,
                       last.date = ld,
                       freq.data = int,
                       do.cache = FALSE,
                       thresh.bad.data = 0)

#Generando data frame con los valores
data_precio_amzn<-data1$df.tickers
colnames(data_precio_amzn)
#>  [1] "ticker"              "ref.date"           
#>  [3] "volume"              "price.open"         
#>  [5] "price.high"          "price.low"          
#>  [7] "price.close"         "price.adjusted"     
#>  [9] "ret.adjusted.prices" "ret.closing.prices"
data_precio_tls<-data2$df.tickers
colnames(data_precio_tls)
#>  [1] "ticker"              "ref.date"           
#>  [3] "volume"              "price.open"         
#>  [5] "price.high"          "price.low"          
#>  [7] "price.close"         "price.adjusted"     
#>  [9] "ret.adjusted.prices" "ret.closing.prices"
#necesitamos convertir la serie de tiempo de precios en retornos continuos compuestos de los precios de apertura
data_precio_amzn$ccrAMZN<-c(NA ,100*diff(log(data_precio_amzn$price.open)))#agregamos un valor NA al principio
data_precio_amzn$ccrAMZN#estos son los retornos
#>  [1]          NA  -3.2011678   2.1889913   5.3061639
#>  [5]  -5.6279333 -11.0646538   1.8052718   7.2089622
#>  [9] -29.3475086  -0.1185366 -13.9945965  23.8807273
#> [13]  -6.8696583

data_precio_tls$ccrTSLA<-c(NA ,100*diff(log(data_precio_tls$price.open)))#agregamos un valor NA al principio
data_precio_tls$ccrTSLA
#>  [1]         NA   5.796888  38.591933   1.361865  -1.121972
#>  [6] -20.478772  -7.264574  21.765521 -22.795320 -13.089771
#> [11] -10.336735  28.307900 -10.009692
#formateando por año y mes
data_precio_tls$ref.date=format(as.Date(data_precio_tls$ref.date), "%m/%Y")
data_precio_amzn$ref.date=format(as.Date(data_precio_amzn$ref.date), "%m/%Y")
#Compararemos con los CETES
CETES_sep2021_2022<-read_excel("BD/CETES-sep2021-2022.xlsx", skip=17)
head(CETES_sep2021_2022)
#> # A tibble: 6 × 2
#>   Fecha               SF43936
#>   <dttm>                <dbl>
#> 1 2021-09-15 00:00:00    4.6 
#> 2 2021-09-23 00:00:00    4.58
#> 3 2021-09-30 00:00:00    4.69
#> 4 2021-10-07 00:00:00    4.81
#> 5 2021-10-14 00:00:00    4.79
#> 6 2021-10-21 00:00:00    4.83
#indice sp500
SP500 <- read_csv("BD/Download Data - INDEX_US_S&P US_SPX.csv")
SP500$ccrSP500<-c(NA ,100*diff(log(SP500$Open)))
names(SP500)[1]<-paste('ref.date')
#formateando por año y mes

#cetes
cete_1_año<-10.10#esto es el rendimiento a un año de un cete gubernamental seguro

#Juntamos el df
CAPM_2<-merge(data_precio_amzn, data_precio_tls, by = c('ref.date'))
CAPM_4<-merge(SP500, CAPM_2, by = c('ref.date'))
CAPM<-data.frame(CAPM_4)

#exceso de retorno
CAPM$excess_ret_AMZN<-CAPM$ccrAMZN-cete_1_año
CAPM$excess_ret_SP500<-CAPM$ccrSP500-cete_1_año
CAPM$excess_ret_TSLA<-CAPM$ccrTSLA-cete_1_año
```


```r
#relacion entre los excesos de demanda
ggplot(CAPM, aes(x=excess_ret_AMZN, y=excess_ret_SP500))+geom_point()+labs(title="Relación de excesos de retornos entre TSLA y AMZN",y="Exceso de demanda de SP500", x="Exceso de demanda de AMZN")+theme_light()
#> Warning: Removed 2 rows containing missing values
#> (geom_point).
```

<div class="figure">
<img src="04-CAPM_files/figure-epub3/TSTSLAAMAZN1-1.png" alt="Relación de excesos de retornos entre AMZN y SP500"  />
<p class="caption">(\#fig:TSTSLAAMAZN1)Relación de excesos de retornos entre AMZN y SP500</p>
</div>


```r
#relacion entre los excesos de demanda
ggplot(CAPM, aes(x=excess_ret_TSLA, y=excess_ret_SP500))+geom_point()+labs(title="Relación de excesos de retornos entre TSLA y AMZN",y="Exceso de demanda de SP500", x="Exceso de demanda de TSLA")+theme_light()
#> Warning: Removed 2 rows containing missing values
#> (geom_point).
```

<div class="figure">
<img src="04-CAPM_files/figure-epub3/TSTSLAAMAZN2-1.png" alt="Relación de excesos de retornos entre TSLA y SP500"  />
<p class="caption">(\#fig:TSTSLAAMAZN2)Relación de excesos de retornos entre TSLA y SP500</p>
</div>


```r
#veamos la regresion lineal
CAPM_lr<-lm(excess_ret_TSLA~excess_ret_SP500,data = CAPM)
summary(CAPM_lr)
#> 
#> Call:
#> lm(formula = excess_ret_TSLA ~ excess_ret_SP500, data = CAPM)
#> 
#> Residuals:
#>     Min      1Q  Median      3Q     Max 
#> -23.980 -13.391  -5.548  11.572  37.067 
#> 
#> Coefficients:
#>                  Estimate Std. Error t value Pr(>|t|)
#> (Intercept)       -3.2334    11.8097  -0.274     0.79
#> excess_ret_SP500   0.5379     1.0789   0.499     0.63
#> 
#> Residual standard error: 20.88 on 9 degrees of freedom
#>   (2 observations deleted due to missingness)
#> Multiple R-squared:  0.02687,	Adjusted R-squared:  -0.08125 
#> F-statistic: 0.2486 on 1 and 9 DF,  p-value: 0.6301
alpha1<-coefficients(CAPM_lr)[1]
alpha1<0
#> (Intercept) 
#>        TRUE
```

De esta manera sabemos que el rendimiento de TSLA NO es mayor debido a que el coeficiente $\alpha=-2.9534$, lo cual indica peores rendimientos al resto del SP500.

## Ejercicio Compara con TSLA con el APPLE


```r
dt3<-"AAPL"
data3<-BatchGetSymbols(tickers = dt3,
                       first.date = pd,
                       last.date = ld,
                       freq.data = int,
                       do.cache = FALSE,
                       thresh.bad.data = 0)
#> Warning: `BatchGetSymbols()` was deprecated in BatchGetSymbols 2.6.4.
#> Please use `yfR::yf_get()` instead.
#> 2022-05-01: Package BatchGetSymbols will soon be replaced by yfR. 
#> More details about the change is available at github <<www.github.com/msperlin/yfR>
#> You can install yfR by executing:
#> 
#> remotes::install_github('msperlin/yfR')
#> 
#> Running BatchGetSymbols for:
#>    tickers =AAPL
#>    Downloading data for benchmark ticker
#> ^GSPC | yahoo (1|1)
#> AAPL | yahoo (1|1) - Got 100% of valid prices | Nice!
data_precio_AAPL<-data3$df.tickers
colnames(data_precio_AAPL)
#>  [1] "ticker"              "ref.date"           
#>  [3] "volume"              "price.open"         
#>  [5] "price.high"          "price.low"          
#>  [7] "price.close"         "price.adjusted"     
#>  [9] "ret.adjusted.prices" "ret.closing.prices"
data_precio_AAPL$ccrAAPL<-c(NA ,100*diff(log(data_precio_AAPL$price.open)))#agregamos un valor NA al principio
data_precio_AAPL$ccrAAPL
#>  [1]         NA  -1.330092   4.875668  11.698469   5.996413
#>  [6]  -2.171531  -5.498712   5.510207 -10.483068  -4.442864
#> [11]  -9.701946  16.851754  -2.751627
data_precio_AAPL$ref.date=format(as.Date(data_precio_AAPL$ref.date), "%m/%Y")
CAPM_3<-merge(data_precio_AAPL, CAPM, by = c('ref.date'))
CAPM_3$excess_ret_AAPL<-CAPM_3$ccrAAPL-cete_1_año
#veamos la regresion lineal
CAPM3_lr<-lm(excess_ret_AAPL~excess_ret_SP500,data = CAPM_3)
summary(CAPM3_lr)
#> 
#> Call:
#> lm(formula = excess_ret_AAPL ~ excess_ret_SP500, data = CAPM_3)
#> 
#> Residuals:
#>      Min       1Q   Median       3Q      Max 
#> -10.9038  -5.4365   0.4641   3.4629  14.1798 
#> 
#> Coefficients:
#>                  Estimate Std. Error t value Pr(>|t|)
#> (Intercept)       -4.7542     4.9105  -0.968    0.358
#> excess_ret_SP500   0.4663     0.4486   1.039    0.326
#> 
#> Residual standard error: 8.682 on 9 degrees of freedom
#>   (2 observations deleted due to missingness)
#> Multiple R-squared:  0.1072,	Adjusted R-squared:  0.007964 
#> F-statistic:  1.08 on 1 and 9 DF,  p-value: 0.3258
alpha2<-coefficients(CAPM3_lr)[1]
alpha2<0
#> (Intercept) 
#>        TRUE
```
