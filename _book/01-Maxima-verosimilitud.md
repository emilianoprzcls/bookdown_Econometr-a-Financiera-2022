# Máxima Verosimilitud 
## El problema
Recordemos que dado $f(y_i | \mathbf{x}_i)$ la función de densidad condicional de $y_i$ dado $\mathbf{x}_i$. Sea $\boldsymbol{\theta}$ un conjunto de parámetros de la función. Entonces la función de densidad conjunta de variables aleatorias independientes $\{ y_i : y_i \in \mathbb{R} \}$ dados los valores $\{ \mathbf{x}_i : \mathbf{x}_i \in \mathbb{R}^K \}$ estará dada por:

\begin{equation}
    \Pi_{i = 1}^{n} f(y_i | \mathbf{x}_i; \boldsymbol{\theta}) = f(y_1, y_2, \ldots, y_n | \mathbf{x}_1, \mathbf{x}_2, \ldots, \mathbf{x}_n; \boldsymbol{\theta}) = L(\boldsymbol{\theta})
    (\#eq:EqLikehood)
\end{equation}

A la ecuación \@ref(eq:EqLikehood) se le conoce como ecuación de verosimilitud. El problema de máxima verosimilitud entonces será:
\begin{equation}
    \max_{\boldsymbol{\theta} \in \boldsymbol{\Theta}} \Pi_{i = 1}^{n} f(y_i | \mathbf{x}_i; \boldsymbol{\theta}) = \max_{\boldsymbol{\theta} \in \boldsymbol{\Theta}} L(\boldsymbol{\theta})
        (\#eq:EqMaxLike)
\end{equation}

Dado que el logaritmo natural es una transformación monotona, podemos decir que el problema de la ecuación \@ref(eq:EqMaxLike) es equivalente a:

\begin{equation}
     \max_{\boldsymbol{\theta} \in \boldsymbol{\Theta}} ln L(\boldsymbol{\theta}) = \max_{\boldsymbol{\theta} \in \boldsymbol{\Theta}} ln \Pi_{i = 1}^{n} f(y_i | \mathbf{x}_i; \boldsymbol{\theta}) = \max_{\boldsymbol{\theta} \in \boldsymbol{\Theta}} \sum_{i = 1}^{n} ln f(y_i | \mathbf{x}_i; \boldsymbol{\theta})
            (\#eq:EqLogML)
\end{equation}

Para solucionnar el problema se tiene que determinar las condicones de primer y segundo orden, las cuales serán:
\begin{equation}
    \frac{\partial}{\partial \boldsymbol{\theta}} ln L(\boldsymbol{\theta}) = \nabla ln L(\boldsymbol{\theta})
          (\#eq:MLCPO)
\end{equation}

\begin{equation}
    \frac{\partial^2}{\partial^2 \boldsymbol{\theta}} ln L(\boldsymbol{\theta}) = \frac{\partial}{\partial \boldsymbol{\theta}} ln L(\boldsymbol{\theta}) \cdot  \frac{\partial}{\partial \boldsymbol{\theta}} ln L(\boldsymbol{\theta}') = H(\boldsymbol{\theta})
             (\#eq:MLCSO)
\end{equation}



La solución estará dada por aquel valor de $\hat{\boldsymbol{\theta}}$ que hace:
\begin{equation*}
    \frac{\partial}{\partial \boldsymbol{\theta}} ln L(\hat{\boldsymbol{\theta}}) = 0
\end{equation*}

A su vez, la varianza será aquella que resulta de:
\begin{equation*}
    Var[\hat{\boldsymbol{\theta}} | \mathbf{X}] = \left( - \mathbb{E}_{\hat{\boldsymbol{\theta}}}[H(\boldsymbol{\theta})] \right)^{-1}
\end{equation*}

## Estimación y simunlación 
### Lanzar una moneda

```r
set.seed(1234)#esto sirve para siempre generar los mismos numeros aleatorios
#rbinom(numero observaciones,numero de ensayos,probabilidad de exito en cada ensayo)
cara<-rbinom(1,100,0.5)
cara#esto nos dice de los 100 ensayos cuantos fueron cara
#> [1] 47
sol<-100-cara
sol
#> [1] 53


#Ahora definiremos la función que encontrará la función de verosimilutud para determinado valor p
#
verosimilitud <- function(p){
  dbinom(cara, 100, p)
}

#si suponemos que la probabilidad sesgada de que caiga cara es 40%
prob_sesgada<-0.4
#es posible calcular la función de que salga cara
verosimilitud(prob_sesgada)
#> [1] 0.02919091
#ahora es posible generar una función de verimilitud negativa 
#para maximizar el valor de la verosimilitud
neg_verosimilitud <- function(p){
  dbinom(cara, 100, p)*-1
}
neg_verosimilitud(prob_sesgada)
#> [1] -0.02919091
# unamos la función nlm() para maximizar esta función no linear
#?nlm()
nlm(neg_verosimilitud,0.5,stepmax=0.5)#se pone un parametro porque sabemos que hay un 0.5 de probabilidad de que caiga cara
#> $minimum
#> [1] -0.07973193
#> 
#> $estimate
#> [1] 0.47
#> 
#> $gradient
#> [1] 1.589701e-10
#> 
#> $code
#> [1] 1
#> 
#> $iterations
#> [1] 4
```
Si bien el ejercicio anterior es un tanto repetitivo debido a que sabemos que hay un 50% de que caiga una moneda de un lado o otro. Esto ejemplifica la manera en la que se utiliza el metodo de maximización de máxima verosimilitud.

