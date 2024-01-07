#import "@preview/tablex:0.0.7": tablex, gridx, hlinex, vlinex, colspanx, rowspanx, cellx

#set page(paper: "a4", numbering: "1", number-align: top + right, margin: 0.80in)

// margins and spacing
#show heading: set block(above: 2em, below: 1em)
#set par(
  leading: 1em,
  linebreaks: "optimized",
)
#set block(spacing: 2em)
#show figure: set block(spacing: 2.5em)

// numbering
#set heading(numbering: "1.1 ")
#set math.equation(numbering: "(1)")

// font
#set text(font: "New Computer Modern", lang: "en")
#set math.vec(delim: "[")

#align(center, text(16pt)[
  *How do different types of optimization algorithms affect the performance of machine learning models?*
])

= Introduction
- Machine learning
- Supervised learning
- Applicaitons of machine learning in CS and math
- I'm interested in NLP, and optimization is the backbone of any NN training. Thereore, it is good to understand the fundamentals.

= The linear regression task
- The specific machine learning problem chosen for this investigation will be a linear regression task.
- Linear regression is a supervised learning algorithm that models the relationship between a scalar dependent variable $y$ and one or more independent variables $X$.
- To look at the suitability of each optimization algorithm to he performance of each optimization algorithm is be tested on a real-world dataset of information about used cars.
- For instance, let us define our problem to be investigating the relationship between the mileage of a car and its price.
- A performant linear regression model for this problem would help us predict the price of a car given its mileage, both interpolating and extrapolating.
- Cleaning and extracting the relevant data from the dataset, we get the following scatterplot:

*scatterplot of data*

= Optimization and loss functions
- Optimization is the process of finding the best solution to a problem. In this problem, it is finding the equation of the line that best fits the data, accoring to some metric.
- In machine learning, this metric is called a loss function, and the goal of optimization is to minimize the loss function.
- There are many types of loss functions, which depends on the problem and type of data. This includes "square of Euclidean distance, crossentropy, contrast loss, hinge loss, information gain," etc.
- For linear regression, a common loss function is the sum of squared residuals, defined as 
$ "RSS" = sum_(i=1)^n (y_i - f(x_i))^2 $ <generic_loss_function>
where $y_i$ is the $i^"th"$ actual value of the variable we are trying to predict ("ground truth"), $f(x_i)$ is the predicted value of $y_i$ given the $i^"th"$ value of the independent variable $x$, and $n$ is the number of data points.

- In this case, $y$ is the price of the car, $x$ is the mileage of the car, and $f(x)$ is the predicted price of the car given its mileage.
- There are many methods of optimizing this loss function, and we will be evaluating two contrasting methods: gradient descent and simulated annealing. Gradient descent involves ... while simulated annealing involves ...

= Gradient descent and stochastic gradient descent (SGD)
- Gradient descent is an optimization algorithm that minimizes a function by taking steps proportional to the negative of the gradient of the function at the current point.

== The gradient descent algorithm
#gridx(
  columns: (50%, 50%),
  inset: 8pt,
  
  // fill right column bg grey... if theres a better way PLS FIX
  map-cols: (col, cells) => cells.map(c =>
    if c == none {
      c
    } else {
      (..c, fill: if col == 1 { luma(250) } else {  })
    }
  ),

  [
    - Since this is a linear regression task, the function $f(x)$ is a linear line with equation $f(x) = m x + b$.

    - Each squared residual comes from the difference between the actual value of $y$ and the predicted value of $y$, $f(x_i)$. Therefore, the loss function can be rewritten as
    $ "RSS" = sum_(i=1)^n (y_i - (m x_i + b))^2 $ <linear_loss_function>

    - Calculating the summation, we can substitute $y_i$ and $x_i$ with each datapoint's value, leaving the loss function in terms of m and b as the targets for optimization. This is where gradient descent comes in.
  ],
  [
    #figure(
      image("residual.png"),
      caption: [Residual between one datapoint and an arbitrary regression line]
    )
  ],
  [
    - The resulting loss function is a 3D paraboloid, with the y-axis representing the sum of the squared residuals, the x-axis representing different values for the slope m, and the z-axis representing different values for the y-intercept b.
    - The goal is to find the minimum of this paraboloid, which is the point where the loss function is minimized.
  ],
  [
    #figure(
      image("3d.png"),
      caption: [3D graph of loss function]
    )

    - The equation of the loss function, calculated programatically due to the large number of datapoints, is simplified as.
  ],
  colspanx(2)[*Initialization*],
  [
    - We define an initial solution, where we choose random values for the parameters $m$ (slope) and $b$ (y-intercept).
    - Let's call them $m_0$ and $b_0$.
  ],
  [
    - Let's set the intercept to 0 and the slope to 1.
    - $m_0 = 1$ and $b_0 = 0$.
  ],
  colspanx(2)[*Computing the gradient*],
  [
    - This is done by taking the derivative of the loss function with respect to m and b. Two or more derivatives of the same function give us the gradient, which is essentially a vector that points in the direction of the steepest ascent of the loss function.

    $ (delta"RSS")/(delta"m") = -2 sum_(i=1)^n x_i (y_i - (m x_i + b)) $

    $ (delta"RSS")/(delta"b") = -2 sum_(i=1)^n (y_i - (m x_i + b)) $

    where the gradient is $vec((delta"RSS")/(delta"m"), (delta"RSS")/(delta"b"))$
  ],
  [
    Substituting these values into the gradient, we get the gradient ???.

   
  ],
  colspanx(2)[*Parameter update*],
  [
    - This slope is subsituted into the formula for the step size, which is the amount by which each target for optimization is changed in each iteration.

    $ "Step size"_"m" = (delta"RSS")/(delta"m") times gamma $

    $ "Step size"_"b" = (delta"RSS")/(delta"b") times gamma $
 
    - The learning rate $gamma$ is a hyperparameter that determines the size of the steps taken towards the minimum of the loss function. 
    - A small learning rate might lead to slow convergence, while a large learning rate can cause overshooting and instability. 
  ],
  [
    Let's set the learning rate $gamma$ to 0.01 initially. This results in step sizes of:

    $"Step size"_"intercept" = ? times 0.01 = -0.016$
    $"Step size"_"slope" = ? times 0.01 = -0.008$
  ],
  [
    - The step sizes are then subtracted from the intercept and slope, respectively, to get the new values for the intercept and slope.
  ],
  [
    $"New intercept" = 0 - -0.016 = 0.016$
    $"New slope" = 1 - -0.008 = 1.008$

    Comparing the initial line to the new line after the first iteration, we can see that the line has moved closer to an optimal solution, and the loss function has decreased.
  ],
  colspanx(2)[*Convergence check and iteration*],
  [
    - This process of substituting the parameter values into the gradient, then calucating the new step sizes, and finally the new parameters, is repeated until the loss function converges to a minimum.
    - Convergence can be determined by setting a threshold for the step size (when it is sufficiently small) or limiting the number of iterations.
  ]
)

== Gradient descent on our problem
- The algorithm ran through 1000 iterations, and the final values for the slope and intercept were $m = 0.0006$ and $b = 0.0001$.
- The following is a sampling of the algorithm's progression:

== Variants
  - A variant of gradient descent exists called stochastic gradient descent, which is used when the dataset is too large to be processed in one iteration with sufficient speed.
  - In stochastic gradient descent, a randomly selected subset of the data at every step is used to calculate the new paramenets, rather than the full dataset.
  - This reduces the computation time needed to caluclate the derivatives of the loss function, as fewer datapoints are used in the summation of the loss function.

== Limitations
  - Gradient descent has limitations, especially in cases of non-convex loss functions or when the data has multiple local minima. 

= Simulated annealing (SA)
- Simulated annealing is a probabilistic technique for approximating the global optimum of a complex function. It is particularly useful in situations where the function may have several local minima, making traditional gradient-based methods less effective.
- In the context of optimization, SA uses the concept of 'temperature' to control the search process. At high temperatures, the algorithm is more likely to accept changes that increase the function value (or 'energy'), allowing it to explore a wide range of solutions. As the temperature decreases, the algorithm becomes more selective, focusing on refining and improving the current solution. This process helps SA to potentially escape local minima and converge towards a global minimum.

== The simulated annealing algorithm
#gridx(
  columns: (50%, 50%),
  inset: 8pt,

  // fill right column bg grey... if theres a better way PLS FIX
  map-cols: (col, cells) => cells.map(c =>
    if c == none {
      c
    } else {
      (..c, fill: if col == 1 { luma(250) } else {  })
    }
  ),

  colspanx(2)[*Initialization*],
  [
    - We define an initial solution, where we choose values for the parameters $m$ and $b$.
    - Let's call them $m_0$ and $b_0$.
    - We also set an initially high temperature $T_0$.
  ],
  [
    - Let's choose the same initial solution as we did in gradient descent, $m_0 = 1$ and $b_0 = 0$.
  ],
  colspanx(2)[*Iteration*],
  [
    - A new candidate solution is generated by perturbing the current solution. This is done by adding a random value to the current solution.
  ],
  [
    $m' = ??$

    $b' = ??$
  ],
  colspanx(2)[*Evolution and acceptance*],
  [
    - The new candidate solution is evaluated by the difference in the loss function, $Delta"RSS"$.
    - If the candidate solution is better than the current solution, that is, $Delta"RSS" < 0$, then the candidate solution is accepted as the new current solution.
    - If the candidate solution is worse than the current solution, that is, $Delta"RSS" > 0$, then the candidate solution is accepted as the new current solution with a probability of $P("accept") = e^(-Delta"RSS"/T)$.
  ],
  [
    - This iteration, the candidate solution is worse than the current solution, so we calculate the probability of accepting the candidate solution.
  ],
  colspanx(2)[*Cooling*],
  [
    - The temperature is decreased by a cooling factor $alpha$.
    - This is done to reduce the probability of accepting worse solutions as the algorithm progresses.
    - For instance, a simple exponential decay might be
    $ T_"new" = alpha times T_"old" $
    - $alpha$ is a constant < 1, controlling the rate of temperature decrease.
  ],
  [
    - Let's set $alpha = 0.9$.
    - The new temperature is then
    $ T_"new" = 0.9 times T_"old" 
    \ = 0.9 times 100 
    \ = 90 $
  ],
  colspanx(2)[*Termination*],
  [
    The algorithm repeats the iteration step until a stopping criterion is met. This could be a sufficiently low temperature, a maximum number of iterations, or a minimal change in the loss function over a certain number of iterations.
  ]
)

== Simulated annealing on our problem
- The algorithm ran through 1000 iterations, and the final values for the slope and intercept were $m = 0.0006$ and $b = 0.0001$.
- The following is a sampling of the algorithm's progression:

= Analysis
- Comparing the two methods, we see that
- Comparing to the analytical solution.

= Conclusion

