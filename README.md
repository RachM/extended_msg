Extended Landscape Generator
============

This generator is based on the Max Set of Gaussians Landscape Generator.

**Source Code for the Extended MSG Generator**

The following code is to use the Extended MSG Generator. It has 'ridge', 'valley' and 'random' landscapes.

  - Initialization Function: initialize.m
  - Fitness Function: fitness.m
  - Visualization Function: plotlandscape.m

Example Usage:

To create a ridge within [-1, 1] with:
  - 20 Gaussian components
  - Global height of one.
  - Maximum local height of 0.5.
  - Gaussian component variance of 0.05.
  - Gaussian component rotation of 45 degrees to x-axis.
  - Ridge rotation of 90 degrees to x-axis.

In Matlab:
	>> initialize(2,20,1,-1,1,0.5,0.05,'ridge',struct('gaussianRotation',45,'ridgeRotation',90))
	>> plotlandscape(1,-1,100)

**Source Code for the "Active Search"**

The following code uses a (1+1)-ES to actively search for landscape instances that maximises the mean fitness difference between two algorithms.

  - Constants: constants.m
  - (1+1)-ES: one_one_es.m
  - Mutation Function: mutate.m
  - Experiment Function: experiment.m
  - Algorithm Wrapper: wrapper_algorithm.m
  - Landscape Initialization Wrapper: wrapper_initialize.m

Example Usage:

To find the mean fitness difference over 30 trials between EMNA and UMDA (with wrappers 'wrapper_emna.m' and 'wrapper_umda.m' respetively) on 10 ridge landscape with:
  - 20 Gaussian components
  - Global height of one.
  - Maximum local height of 0.5.
  - Gaussian component variance of 0.05.
  - Gaussian component rotation of 45 degrees to x-axis.
  - Ridge rotation of 90 degrees to x-axis.

In Matlab:
	>> experiment(@wrapper_emna,@wrapper_umda,10,30,'ridge',struct('gaussianRotation',45,'ridgeRotation',90))

Now to use a (1+1)-ES to find ridge landscapes with a mean fitness difference of 0.3 between EMNA and UMDA. Each parameterisation is tested on 10 landscapes instances, with 30 algorithm comparisons per landscape instance:

	>> one_one_es(@wrapper_emna,@wrapper_umda,10,30,'ridge',0.3)