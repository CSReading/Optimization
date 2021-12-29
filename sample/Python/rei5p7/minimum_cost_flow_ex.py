import networkx as nx
G = nx.DiGraph()
G.add_node('v1', demand = -6.0)
G.add_node('v2', demand =  2.0)
G.add_node('v3', demand =  0.0)
G.add_node('v4', demand =  4.0)
G.add_edge('v1', 'v2', weight = 20.0, capacity = 4.0)
G.add_edge('v1', 'v3', weight = 30.0, capacity = 3.0)
G.add_edge('v2', 'v3', weight = 10.0, capacity = 3.0)
G.add_edge('v2', 'v4', weight = 50.0, capacity = 4.0)
G.add_edge('v3', 'v4', weight = 40.0, capacity = 6.0)
flowDict = nx.min_cost_flow(G)
print(flowDict)
