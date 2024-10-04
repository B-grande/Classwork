% Step 1: Define the adjacency matrix for the given network (symmetric version)
A = [0 1 0 0 0 0 0 0 0 0 0;
     1 0 1 1 0 0 0 0 0 0 0;
     0 1 0 0 0 0 0 0 0 0 0;
     0 1 0 0 1 1 1 0 0 0 0;
     0 0 0 1 0 0 0 0 0 0 0;
     0 0 0 1 0 0 1 1 0 1 0;
     0 0 0 1 0 1 0 0 0 0 0;
     0 0 0 0 0 1 0 0 0 0 0;
     0 0 0 0 0 0 0 0 0 1 0;
     0 0 0 0 0 1 0 0 1 0 1;
     0 0 0 0 0 0 0 0 0 1 0];

% Ensure the matrix is symmetric (undirected graph)
A = A + A';

% Step 2: Create the graph
G = graph(A);

% Step 3: Define the node labels (city names)
nodeLabels = {'Anchorage', 'Seattle', 'Salt Lake City', 'San Francisco', ...
              'Los Angeles', 'Chicago', 'Dallas', 'New Orleans', ...
              'New York City', 'Boston', 'Bangor'};

% Step 4: Calculate the susceptibility index between each pair of cities
numNodes = numnodes(G);
susceptibilityIndex = zeros(numNodes, numNodes); % Initialize matrix to store susceptibility index
allPaths = cell(numNodes, numNodes);             % Cell array to store all paths

for i = 1:numNodes
    for j = 1:numNodes
        if i ~= j
            % Find all simple paths between nodes i and j
            paths = findAllSimplePaths(G, i, j);
            % Filter paths according to the criteria
            filteredPaths = filterPaths(paths);
            susceptibilityIndex(i, j) = length(filteredPaths);
            allPaths{i, j} = filteredPaths;
        else
            susceptibilityIndex(i, j) = 0;
            allPaths{i, j} = {i};
        end
    end
end

% Optional: Display the susceptibility index in a table format
cityPairs = {};
susceptibilityList = [];
for i = 1:numNodes
    for j = 1:numNodes
        if i ~= j
            cityPairs = [cityPairs; [nodeLabels{i}, ' to ', nodeLabels{j}]];
            susceptibilityList = [susceptibilityList; susceptibilityIndex(i, j)];
        end
    end
end

T = table(cityPairs, susceptibilityList, 'VariableNames', {'Route', 'SusceptibilityIndex'});
disp('Susceptibility Index Between Each Pair of Cities:');
disp(T);

% Function to find all simple paths between two nodes
function paths = findAllSimplePaths(G, startNode, endNode)
    visited = false(numnodes(G), 1);
    path = [];
    paths = {};
    [paths] = DFS(G, startNode, endNode, visited, path, paths);
end

% Depth-First Search to find all simple paths
function [paths] = DFS(G, currentNode, endNode, visited, path, paths)
    visited(currentNode) = true;
    path = [path, currentNode];
    
    if currentNode == endNode
        paths{end+1} = path;
    else
        neighborsNode = neighbors(G, currentNode);
        for idx = 1:length(neighborsNode)
            neighbor = neighborsNode(idx);
            if ~visited(neighbor)
                [paths] = DFS(G, neighbor, endNode, visited, path, paths);
            end
        end
    end
    
    visited(currentNode) = false;
    path(end) = [];
end

% Function to filter paths according to the criteria
function filteredPaths = filterPaths(paths)
    numPaths = length(paths);
    toRemove = false(numPaths, 1);
    
    for i = 1:numPaths
        for j = 1:numPaths
            if i ~= j && ~toRemove(j)
                if isSubpath(paths{i}, paths{j})
                    toRemove(i) = true;
                    break;
                end
            end
        end
    end
    filteredPaths = paths(~toRemove);
end

% Function to check if one path is entirely contained within another
function result = isSubpath(path1, path2)
    result = false;
    len1 = length(path1);
    len2 = length(path2);
    if len1 >= len2
        return;
    end
    for i = 1:(len2 - len1 + 1)
        if isequal(path1, path2(i:i+len1-1))
            result = true;
            return;
        end
    end
end