# dockerpot
Let's Dockerize [TPOT](https://epistasislab.github.io/tpot/)!

## Background

Imagine a quick and dirty [SageMaker Autopilot](https://aws.amazon.com/sagemaker/autopilot/). On your local.  In Docker.

The following implements the [Digits dataset example](https://epistasislab.github.io/tpot/examples/) in the TPOT documentation.

I don't know the TPOT API well at all, so any errors of commission or omission are due to my inexperience.

## Requirements

- [Docker](https://www.docker.com/products/docker-desktop)

## Nice to Haves

- [make](https://www.gnu.org/software/make/manual/make.html)

## Usage

Only the usage with `make` has been documented below.

Take a look at the [Makefile](./Makefile) to see the commands corresponding to the targets.

0. Build the image.
```
make build
```

### Jupyter Notebook Usage
1. To see how to run a Jupyter notebook in the container.
```
make jupyter
```

After you do, you should see something like the following at the command line.
```
docker run --publish 8888:8888 --volume $(pwd)/notebooks:/workspace/notebooks --env ENVIRONMENT=local --detach dockerpot jupyter
769035704fcc5863fed731734a8a6e74ff7ea01f49efa75e1cf5521c0316a384
```

2. Go to http://localhost:8888/notebooks/notebooks/run_minst.ipynb, and run the notebook.

3. Find `tpot_exported_pipeline.py` in the notebooks directory.

4. Stop the container.
```
make stop
```

### Command Line Usage
1. Run the run_minst.py script.
```
make run_minst
```

After you do, you should see something like this at the command line.
```
docker run dockerpot python /workspace/scripts/run_minst.py --volume $(pwd)/scripts:/workspace/scripts
Optimization Progress:  28%|██▊       | 33/120 [01:12<05:48,  4.00s/pipeline]
```
