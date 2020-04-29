# dockerpot
Let's Dockerize [TPOT](https://epistasislab.github.io/tpot/)!

## Background

Imagine a quick and dirty [SageMaker Autopilot](https://aws.amazon.com/sagemaker/autopilot/). On your local.  In Docker.

The following implements the ["Digits dataset example"](https://epistasislab.github.io/tpot/examples/) (i.e., MINST) in the TPOT documentation.

I don't know the TPOT API well at all, so any errors of commission or omission are due to my inexperience with it.

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
1. To see how to run a Jupyter notebook in the container run this.
```
make jupyter
```

After you do, you should see something like the following at the command line.
```
docker run --publish 8888:8888 --volume $(pwd)/notebooks:/workspace/notebooks --detach dockerpot jupyter
68634eea7fcb08ddf751e162ff91f0eb651c6c15ae8d2763e6b5ebb7d06e49b8
```

2. Go to http://localhost:8888/notebooks/notebooks/run_minst.ipynb, and run the notebook.

3. Find [tpot_exported_pipeline.py](./notebooks/tpot_exported_pipeline.py) in the notebooks directory.

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
docker run --volume $(pwd)/scripts:/workspace/scripts dockerpot python /workspace/scripts/run_minst.py
Optimization Progress:   2%|▏         | 2/120 [00:01<01:36,  1.22pipe
```

When it's done, you'll see something like this.
```
docker run --volume $(pwd)/scripts:/workspace/scripts dockerpot python /workspace/scripts/run_minst.py
Generation 1 - Current best internal CV score: 0.9591656340355226             
Generation 2 - Current best internal CV score: 0.9658405617513424
Generation 3 - Current best internal CV score: 0.9710422690348341
Generation 4 - Current best internal CV score: 0.9866363761531047
Generation 5 - Current best internal CV score: 0.9888641057414291

Best pipeline: KNeighborsClassifier(XGBClassifier(input_matrix, learning_rate=1.0, max_depth=9, min_child_weight=11, n_estimators=100, nthread=1, subsample=0.7500000000000001), n_neighbors=1, p=2, weights=distance)
0.9844444444444445
```

2. Find [tpot_exported_pipeline.py](./scripts/tpot_exported_pipeline.py) in the scripts directory.

## Other Things

Use `make docker-clean-unused` to nuke containers on your machine that aren't running.  Watch out.

Use `make docker-clean-all` to kill **all** containers, running or not.  Careful.

Use `make shell` to peek inside the container.
