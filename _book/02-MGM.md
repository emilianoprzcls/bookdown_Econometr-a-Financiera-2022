# Método Generalizado de Momentos (MGM)
## El problema
Retomemos el modelo de regresión lineal tal que:

\begin{equation}
y_i=X_i\beta+u_i
    \label{Eq_reglin}
\end{equation}

Tomando en cuenta los principios de ortogonalidad ($E(Z_iu_i)=0$) y ($rankE(Z_i^{'}X_i)=0$) sabemos que $\beta$ es el único vector de $N\times1$ que resuelve las condiciones de momento de determinada población. En otras palabras, $E[z_i^{'}(y_i-x_i\beta)]=0$ es una solución y $E[z_i^{'}(y_i-x_i\beta)]\neq0$ *NO* es una solución. Debido a que la media muestral son estimadores consistentes de momentos de una población, se puede:

\begin{equation}
N^{-1}\sum_{i=1}^{N}z_i^{'}(y_i-x_i\beta)=0
(\#eq:Eqreglin1asolu1)
\end{equation}

Asumiendo que la ecuación \@ref(eq:Eqreglin1asolu1) tiene L ecuaciones lineales y K coeficientes $\beta$ desconocidos y $K=L$, entonces la matriz $\sum_{i=1}^{N}z_i^{'}x_i$ debe ser no singular para encontrar los coeficientes de la siguiente manera.

\begin{equation}
\hat{\beta}=N^{-1}\left[\sum_{i=1}^{N}z_i^{'}x_i\right]^{-1}\left[\sum_{i=1}^{N}z_i^{'}y_i\right]
(\#eq:Eqreglin1asolu2)
\end{equation}

Para simplificar \@ref(eq:Eqreglin1asolu2) se puede nombrar Z juntando  $z_i$ N veces para crear una matriz de tamaño $NG\times L$. Lo mismo hacemos con X juntando $x_i$ para obtener una de $NG\times K$ y Y obteniendo una $NG\times 1$. Obteniendo:

\begin{equation}
\hat{\beta}=[Z^{'}X]^{-1}[Z^{'}Y]
\end{equation}

Es importante tomar en cuenta cuando el caso en el que hay más ecuaciones lineales que coeficientes $\beta$; es decir, $L\geq K$. En estos casos es muy probrable que no haya solución, por lo que mejor que se puede estimar es pones la ecuación \@ref(eq:Eqreglin1asolu1), tan pequeña como sea posible. Por lo mismo el paso que nos lleva a la ecuación \@ref(eq:Eqreglin1asolu2), debe eliminarse $N^{-1}$. El objetivo:

\begin{equation}
\min_{\beta} \left[\sum_{i=1}^{N}z_i^{'}x_i\beta\right]^{-1}\left[\sum_{i=1}^{N}z_i^{'}y_i\beta\right]
(\#eq:Eqreglin1asolu77)
\end{equation}

Así pues nombramos a W como una matriz simétrica de $W\times W$ donde se genera la variable $b$ que debemos minimizar que sustituye a $\beta$ creando una función cuadrática en la ecuación \@ref(eq:Eqreglin1asolu2).
\begin{equation}
\min_{b}\left[\sum_{i=1}^{N}z_i^{'}x_ib\right]^{-1}\left[\sum_{i=1}^{N}z_i^{'}y_ib\right]
(\#eq:Eqreglin1asolu78)
\end{equation}

\begin{equation}
\therefore\hat{\beta}=[X^{'}Z\hat{W}Z^{'}X]^{-1}[X^{'}Z\hat{W}Z^{'}Y]
\end{equation}

Sin embargo, $X^{'}Z\hat{W}Z^{'}X$ debe ser no singular para que haya una solución. Para esto se asume que $\hat{W}$ tiene un limite de probabilidad no singular. Esto se describe como $\hat{W}\xrightarrow[]{p}W$ y $N\xrightarrow[]{}W\infty$ donde $W$ no es aleatorio, es una matriz positiva definida simétrica de $L\times L$.

