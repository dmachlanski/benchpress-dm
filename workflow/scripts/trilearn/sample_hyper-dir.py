import numpy as np
import json
from networkx.readwrite import json_graph
import networkx as nx
import trilearn.graph.decomposable
from trilearn.distributions import discrete_dec_log_linear as loglin
import pandas as pd
import sys

seed = int(sys.argv[2]) #int(snakemake.wildcards["seed"])
adjmat_filename = sys.argv[5] #snakemake.input["adjmat"]
adjmat = pd.read_csv(adjmat_filename, dtype=int).values
parameters_filename = sys.argv[1] #"params.json"
l = int(sys.argv[3]) #int(snakemake.wildcards["n_levels"])
pseudo_obs = float(sys.argv[4])#float(snakemake.wildcards["pseudo_obs"])

np.random.seed(seed)
graph = nx.from_numpy_array(adjmat)

n_levels = [l] * graph.order()
levels = np.array([range(l) for l in n_levels])

parameters = loglin.sample_hyper_consistent_parameters(graph, pseudo_obs,
                                                        levels)

parameters_flattened = {}
parameters_flattened["no_levels"] = n_levels
for key, val in parameters.iteritems():
    props = {}    
    props["parameters"] = list(val.reshape(np.prod(val.shape)))
    props["clique_nodes"] = list(key)
    parameters_flattened[str(list(key))] = props

with open(parameters_filename, 'w') as outfile:
        json.dump(parameters_flattened, outfile)