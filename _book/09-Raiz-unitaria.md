# Raiz Unitaria
## Definición y formas de No Estacionariedad

Hasta ahora hemos planteado una serie de ténicas de regresión que aplican sólo a procesos o series estacionarias. En esta sección relajaremos la definición de estacionariedad y plantearemos pruebas para determinar cuando una serie es estacionaria bajo tres diferentes especificiones: (1) estacionariedad al rededor de una tendencia determinística; (2) estacionariedad al rededor de una media, y (3) estacionariedad al rededor del cero.

A continuación discutiremos cómo es posible que una serie sea estacionaria al rededor de una tendencia determinística. Diremos que una tendencia es determinística si ésta puede ser aproximada o modelada por un polinomio en función de $t$, la cual incluye posibles transformaciones logarítmicas.

Bajo este enfoque, el proceso está lejos de cumplir con la defición de estacionariedad que hemos establecido en capítulos previos, pero relajaremos el supuesto y reconoceremos que una serie puede ser estacionaria en varianza bajo una tendencia determinística. Así, diremos que la serie será descrita por una ecuación dada por:
\begin{equation}
    Y_t = \sum^m_{j = 0} \delta_j t^j + X_t
    (\#eq:YTrend)
\end{equation}

Donde $X_t$ es un proceso $ARMA(p, q)$ con media cero, que se puede ver como:
\begin{equation}
    \alpha(L) X_t = \beta(L) U_t
        (\#eq:YTrend1)
\end{equation}

Entonces, los momentos y variaza de la ecuación \@ref(eq:YTrend) estaran dados por:
\begin{equation}
    \mathbb{E}[Y_t] = \sum^m_{j = 0} \delta_j t^j = \mu_t
        (\#eq:ETrend)
\end{equation}

Dada la ecuación (\@ref(eq:ETrend) podemos plantear la siguiente ecuación de covarainzas:
\begin{eqnarray}
    \mathbb{E}[(Y_t - \mu_t) \cdot (Y_{t+\tau} - \mu_{t+\tau})] & = & \mathbb{E}[X_t \cdot X_{t+\tau}] \nonumber \\
    & = & \gamma_X(\tau)
            (\#eq:CovTrend)
\end{eqnarray}

Utilizando el resultado de la ecuación \@ref(eq:CovTrend) podemos establecer que:
\begin{equation}
    \mathbb{E}[(Y_t - \mu_t)^2] = \mathbb{E}[X_t^2] = \sigma_X^2
(\#eq:VarTrend)
\end{equation}

Así, las ecuaciones \@ref(eq:ETrend) y \@ref(eq:VarTrend) significan que el proceso descrito por la ecuación \@ref(eq:YTrend) es estacionario pero en varianza. De esta forma a partir de este momento diremos que una serie será estacionaria al rededor de una tendencia determinística si cumple con las condiciones establecidas en las ecuaciones \@ref(eq:ETrend), \@ref(eq:VarTrend) y \@ref(eq:YTrend).

Dicho lo anterior estudiaremos el concepto de raíz unitaria de un proceso estocástico o de una serie de tiempo. Partamos de platear que un proceso AR(1) tiene raíz unitaria cuando el cual el coeficiente $a_1 = 1$, es decir:
\begin{equation}
    Y_t = Y_{t-1} + U_t
    (\#eq:UR1)
\end{equation}

Donde $U_t$ es un proceso pueramente aleatorio con media cero, varianza constante y autocovarianza cero (0), al cual nos referiremos simplemente como ruido blanco. Supongamos ahora que incluímos un término constante en la ecuación \@ref(eq:UR1), de forma que tenemos:
\begin{equation}
    Y_t = \delta + Y_{t-1} + U_t
    (\#eq:UR2)
\end{equation}

Tomando a la ecuación \@ref(eq:UR2) y suponiendo que existe un valor inicial $Y_0$ de la serie podemos plantear la sguiente secuencia de expresiones:
\begin{eqnarray*}
    Y_1 & = & \delta + Y_0 + U_1 \\
    Y_2 & = & \delta + Y_1 + U_2 \\
    & = & \delta + (\delta + Y_0 + U_1) + U_2 \\
    & = & 2 \times \delta + Y_0 + U_1 + U_2
\end{eqnarray*}

Si repitieramos la sustitución sucesiva anterior hasta el momento $t$ encontrariamos que la ecuación de la solución general que describe a un $AR(1)$ con término constante que tiene raíz unitaria es de la forma:
\begin{equation}
    Y_t = t \delta + Y_0 + \sum_{i=1}^t U_i
    (\#eq:UR3)
\end{equation}

La ecuación \@ref(eq:UR3) es equivalente a la ecuación \@ref(eq:YTrend). A la ecuación \@ref(eq:UR3) también se le conoce como proceso con Drift o con término constante, indistintamente, ya que el componente de Drift suele asociarse a la posibilidad de incorporar el efecto de los residuales pasados, lo cual es posible simplemente agregando una constante.s

Si revisamos el comportamiento de sus momentos y varianza de la ecuación \@ref(eq:UR3) encontramos que:
\begin{eqnarray*}
    \mathbb{E}[Y_t] & = & Y_0 + \delta t = \mu_t \\
    Var[Y_t] & = & t \sigma^2 = \gamma(0, t) \\
    Cov(Y_t, Y_{t+\tau}) & = & (t - \tau) \sigma^2 = \gamma(t, \tau)
\end{eqnarray*}

De esta forma, la ecuación \@ref(eq:UR3) no describe un proceso estacionario, sólo podría ser estacionario si $t = 1$, en cualquier otro caso sería no estacionario en varianza. Ahora hagamos un resumen y acordemos notación que se utilizará en esta sección. Supongamos un proceso o serie de tiempo que es decrito por la siguiente ecuación:
\begin{equation}
    Y_t = \delta + Y_{t-1} + X_t
    (\#eq:UR4)
\end{equation}

Donde $X_t$ es un $ARMA(p, q)$ con media cero. Si definimos a $\Delta Y_t = Y_t - Y_{t-1}$, entonces la ecuación \@ref(eq:UR4) la podemos escribir como:
\begin{equation}
    \Delta Y_t = \delta + X_t
    (\#eq:UR5)
\end{equation}

A la ecuación \@ref(eq:UR5) la denominaremos como un proceso estacionario en diferencias o simplemente como un proceso integrado. Así utilizaremos la siguiente definición.

Sea un proceso estocástico $Y$, decimos que este es integrado de orden $d$, $I(d)$, si este puede transformarse a uno estacionacionario, que sea invertible, mediante la diferenciación del mismo $d$-veces, es decir:
\begin{equation}
    (1 - L)^d Y_t = \delta + X_t
    (\#eq:UR6)
\end{equation}

Donde $X_t$ es un proceso $ARMA(p, q)$. De lo cual se infiere que en la ecuación \@ref(eq:UR6) $Y_t$ será una $ARIMA(p, d, q)$, el cual contiene $d$ raíces unitarias. A estos procesos también se les conoce como procesos con tendencia estocástica.

Dada la discusión annterior, a continuación platearemos un resumen de cuales son los dos casos a los cuales nos referiremos como procesos que no son estacionarios en media, pero que si lo son en varianza. Estos casos son:
\begin{eqnarray}
    Y_t & = & Y_0 + \delta t + U_t \\
        (\#eq:ARR1)
\end{eqnarray}

\begin{eqnarray}
    Y_t & = & Y_0 + \delta + \sum_{i = 1}^t U_t
            (\#eq:ARR2)
\end{eqnarray}

Ambos casos no son estacionarios en media, pero si lo son en varianza. De ambos podemos decir que los choques o innovaciones del término de error tienen un efecto transitorio en el primero, pero permanentes en el segundo.

## Pruebas de Raíces Unitarias

En esta sección plantearemos una serie de pruebas estadísticas para determinar cuando una serie puede ser estacionaria bajo tres posibles casos: (1) estacionariedad al rededor de una tendencia determinística; (2) estacionariedad al rededor de una media, y (3) estacionariedad al rededor del cero.

## Dickey - Fuller (DF)

Partamos de una forma del proceso $Y_t$ dada por:
\begin{equation}
    Y_t = \sum_{j = 0}^m \delta_j t^j + X_t
(\#eq:URDFG)
\end{equation}

Donde $X_t$ es un $ARMA(p, q)$ con media cero. Esta prueba asume que $m = 1$, por lo que utilizaremos un modelo del tipo:
\begin{equation}
    Y_t = \alpha + \delta t + \rho Y_{t-1} + U_t
    (\#eq:URDF)
\end{equation}

Si, el $AR(1)$ planteado tiene raíz unitaria, es decir, $\rho = 1$, entonces tendríamos:
\begin{eqnarray*}
    Y_t & = & \alpha + \delta t + Y_{t-1} + U_t \\
    \Delta Y_t & = & \alpha + \delta t + U_t
\end{eqnarray*}

De esta forma, para determinar si una serie tiene raíz unitaria basta con probar la hipótesis nula de que $H_0 : \rho = 1$, junto con las diferentes combinaciones que impliquen restricciones respecto a $\delta$ y $\alpha$.

En resumen, la prueba DF consiste en asumir un modelo general dado por la ecuación \@ref(eq:URDF) y probar tres especificaciones distintas que serían válidas bajo $H_0 : \rho = 1$:

1. Modelo A: con intercepto y tendencia:
    \begin{equation*}
        \Delta Y_t = \alpha + \delta t + \beta Y_{t-1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \beta = \rho - 1 = 0$ contra $H_a : \beta < 0$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario al rededor de una tendencia determinística.
    
2. Modelo B: con intercepto:
    \begin{equation*}
        \Delta Y_t = \alpha + \beta Y_{t-1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \beta = \rho - 1 = 0$ contra $H_a : \beta < 0$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario al rededor de una constante.
    
3. Modelo C: sin intercepto y tendencia:
    \begin{equation*}
        \Delta Y_t = \beta Y_{t-1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \beta = \rho - 1 = 0$ contra $H_a : \beta < 0$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario sin considerar una constante o una tendencia determinística, es decir, es un proceso puramente aleatorio.

### Dickey - Fuller Aumentada (ADF)

A diferencia de un modelo AR(1) para el caso de una prueba DF como en la ecuación \@ref(eq:URDF), en una prueba ADF se asume que el proceso es un AR(p) de la forma (por simplicidad hemos omitido el término constante y el término de tendencia determinística):

\begin{equation}
    Y_t = a_1 Y_{t-1} + a_2 Y_{t-2} + \ldots + a_p Y_{t-p} + U_t
    (\#eq:URADF)
\end{equation}

Haciendo una sustitución de términos similar a las que hemos planteado en otras secciones podemos reexpresar la ecuación \@ref(eq:URADF) en su versión en diferencias siguiendo el proceso:
\begin{equation}
    Y_t = \rho Y_{t-1} + \theta_1 \Delta Y_{t-1} + \theta_2 \Delta Y_{t-2} + \ldots + + \theta_{p-1} \Delta Y_{t-p+1} + U_t 
                (\#eq:ARR3)
\end{equation}

Donde $\rho = \theta_0 = \sum_{j = 1}^p a_j$, $\theta_i = - \sum_{j = i + 1}^p a_j$, $i = 1, 2, \ldots, p-1$. Así, si el proceso AR(p) tiene raíz unitaria entonces ceremos que:
\begin{eqnarray*}
    1 - a_1 - a_2 - \ldots - a_p & = & 0 \\
    \rho & = & 1
\end{eqnarray*}

De donde podemos establecer que el modelo general de una prueba ADF será:
\begin{equation}
    \Delta Y_{t-1} = \alpha + \beta t + (\rho - 1) Y_{t-1} + \theta_1 \Delta Y_{t-1} + \theta_2 \Delta Y_{t-2} + \ldots + \theta_k \Delta Y_{t-k} + U_t
            (\#eq:ARR4)
\end{equation}

Donde $U_t$ es un proceso puramente aleatorio y $k$ es elegido de tal manera que los residuales sean un proceso puramente aleatorio. En resumen, la prueba DF consiste en asumir un modelo general dado por la ecuación \@ref(eq:URADF), que incluya constante y tendencia, y probar tres especificaciones distintas que serían válidas bajo $H_0 : \rho = 1$:

1. Modelo A: con intercepto y tendencia:
    \begin{equation*}
        \Delta Y_t = \alpha + \delta t + \beta Y_{t-1} + \theta_1 \Delta Y_{t-1} + \theta_2 \Delta Y_{t-2} + \ldots + \theta_{p-1} \Delta Y_{t-p+1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \beta = \rho - 1 = 0$ contra $H_a : \beta < 0$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario al rededor de una tendencia determinística.
    
2. Modelo B: con intercepto:
    \begin{equation*}
        \Delta Y_t = \alpha + \beta Y_{t-1} + \theta_1 \Delta Y_{t-1} + \theta_2 \Delta Y_{t-2} + \ldots + \theta_{p-1} \Delta Y_{t-p+1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \beta = \rho - 1 = 0$ contra $H_a : \beta < 0$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario al rededor de una constante.
    
3. Modelo C: sin intercepto y tendencia:
    \begin{equation*}
        \Delta Y_t = \beta Y_{t-1} + \theta_1 \Delta Y_{t-1} + \theta_2 \Delta Y_{t-2} + \ldots + \theta_{p-1} \Delta Y_{t-p+1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \beta = \rho - 1 = 0$ contra $H_a : \beta < 0$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario sin considerar una constante o una tendencia determinística, es decir, es un proceso puramente aleatorio.

### Phillips - Perron (PP)

Una tercera prueba es la de PP, la cual también está basada en una AR(1) dado por la ecuación:
\begin{equation}
    Y_t = d \eta + \rho Y_{t-1} + U_t
    (\#eq:URPP)
\end{equation}

Donde $d$ incluye a cualquiera de los componentes determinísticos como constante y tendencia. Al igual que los casos pasados, la hipótesis a probar era $H_0 : \rho = 1$ contra la alternativa $H_a : |{\rho}| < 1$, y asumimos una estructura MA(q) es el término de error de la forma $U_t = \psi(L) \varepsilon_t = \psi_0 \varepsilon_t + \psi_1 \varepsilon_{t-1} + \ldots + \psi_p \varepsilon_{t-p}$, con $\varepsilon_t$ es un ruido blanco con media cero y varianza $\sigma^2$. En este modelo se elige el valor $p$ que hace que el componente sea un MA(p). Las tablas estadísticas de PP para esta prueba pueden utilizar una estadística $Z_\tau$ o $Z_\rho$, las cuales se pueden emplear indistintamente.

En resumen, la prueba PP consiste en asumir un modelo general dado por la ecuación \@ref(eq:URPP) y probar dos especificaciones distintas que serían válidas bajo $H_0 : \rho = 1$, ambas considerando un compenente Drift:

1. Modelo A: con intercepto y tendencia:
    \begin{equation*}
        Y_t = \alpha + \delta t + \rho Y_{t-1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \rho = 1$ contra $H_a : |{\rho}| < 1$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario al rededor de una tendencia determinística.
    
2. Modelo B: con intercepto:
    \begin{equation*}
        Y_t = \alpha + \rho Y_{t-1} + U_t
    \end{equation*}
    Buscamos probar si $H_0 : \rho = 1$ contra $H_a : |{\rho}| < 1$, por lo que es una prueba de una cola. Otra forma de decirlo, es probamos si el proceso tiene raíz unitaria contra si el proceso es estacionario al rededor de una constante.


### Kwiatkowsky - Phillips - Schmidt - Shin (KPSS)

La prueba KPSS considera que el proceso es estacionario bajo la hipótesis nula, lo cual hace una diferencia respecto de las anteriores pruebas. El modelo considerado es:
\begin{equation}
    Y_t = \delta t + \xi_t + U_t
                (\#eq:ARR5)
\end{equation}

Donde $U_t$ es un proceso estacionario y $\xi_t$ es un ruido blanco descrito por la forma: $\xi_t = \xi_{t-1} + \varepsilon_t$, donde $\varepsilon_t$ es un proceso normalmente distribuido con media cero y varianza $\sigma^2_\varepsilon$.

Así, bajo la hipótesis nula $H_0 : \sigma^2_\varepsilon = 0$, $\xi$ se vuelve una constante y el proceso puede tener una tendencia estacionaria. Dado el planteamiento de la prueba, los valores críticos al 95\% son: 

1. 0.146, para un modelo con tendencia
2. 0.463, para un modelo con constante

## Ejemplo

```r
#install.packages("pacman")
#pacman nos permite cargar varias librerias en una sola línea
library(pacman)
pacman::p_load(tidyverse,BatchGetSymbols,ggplot2,lubridate,readxl,forecast,stats,stargazer,knitr,tseries)
```


```r
#Primero determinamos el lapso de tiempo
pd<-as.Date("2002/9/30") #primer fecha
pd
#> [1] "2002-09-30"
#> [1] "2021-09-18"
ld<- as.Date("2021/09/30")#última fecha
ld
#> [1] "2021-09-30"
#Intervalos de tiempo
int<-"monthly"

#Datos a elegir
dt<-c("AMZN")

#Descargando los valores
data1<- BatchGetSymbols(tickers = dt,
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
```


```r
#original
price_amazn_ts<-ts(data_precio_amzn$price.open, frequency = 12, start=c(2002,09))
#logartimo
lprice_amazn_ts<-ts(log(data_precio_amzn$price.open), frequency = 12,start=c(2002,09))
#diferencias logaritmicas(cambio porcential)
dlprice_amazn_ts<-ts(log(data_precio_amzn$price.open)-lag(log(data_precio_amzn$price.open),1), frequency = 12, start=c(2002,10))
```

## DF test

```r
dlprice_amazn_ts<-na.omit(dlprice_amazn_ts)
adf.test(dlprice_amazn_ts, k=0) # DF test
#> Warning in adf.test(dlprice_amazn_ts, k = 0): p-value
#> smaller than printed p-value
#> 
#> 	Augmented Dickey-Fuller Test
#> 
#> data:  dlprice_amazn_ts
#> Dickey-Fuller = -15.125, Lag order = 0, p-value =
#> 0.01
#> alternative hypothesis: stationary
```

## ADF test

```r
adf.test(dlprice_amazn_ts) # DF test
#> Warning in adf.test(dlprice_amazn_ts): p-value smaller than
#> printed p-value
#> 
#> 	Augmented Dickey-Fuller Test
#> 
#> data:  dlprice_amazn_ts
#> Dickey-Fuller = -5.8711, Lag order = 6, p-value =
#> 0.01
#> alternative hypothesis: stationary
```

## PP test

```r
pp.test(dlprice_amazn_ts) # DF test
#> Warning in pp.test(dlprice_amazn_ts): p-value smaller than
#> printed p-value
#> 
#> 	Phillips-Perron Unit Root Test
#> 
#> data:  dlprice_amazn_ts
#> Dickey-Fuller Z(alpha) = -221.54, Truncation lag
#> parameter = 4, p-value = 0.01
#> alternative hypothesis: stationary
```

## PP test

```r
pp.test(dlprice_amazn_ts) # DF test
#> Warning in pp.test(dlprice_amazn_ts): p-value smaller than
#> printed p-value
#> 
#> 	Phillips-Perron Unit Root Test
#> 
#> data:  dlprice_amazn_ts
#> Dickey-Fuller Z(alpha) = -221.54, Truncation lag
#> parameter = 4, p-value = 0.01
#> alternative hypothesis: stationary
```

## KPSS test

```r
kpss.test(dlprice_amazn_ts) # DF test
#> Warning in kpss.test(dlprice_amazn_ts): p-value greater than
#> printed p-value
#> 
#> 	KPSS Test for Level Stationarity
#> 
#> data:  dlprice_amazn_ts
#> KPSS Level = 0.033772, Truncation lag parameter = 4,
#> p-value = 0.1
```

Claramente podemos ver que todos los tests arrojan que se rechaza la hipótesis nula de $\beta_0=1$ y, por consiguiente, es estacionaria.
