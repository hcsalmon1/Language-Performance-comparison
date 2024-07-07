



import time


NUMBER_OF_CITIES:int = 20;
globalMinDistance:int = 2147483647;
distanceMatrix:int = [
    [15, 17, 47, 29, 16, 23, 93, 8, 66, 1, 76, 4, 14, 98, 55, 76, 10, 10, 2, 90, ],
    [43, 52, 48, 75, 81, 64, 54, 13, 65, 34, 76, 46, 72, 92, 79, 72, 63, 31, 78, 98, ],
    [7, 12, 52, 96, 24, 13, 3, 37, 28, 92, 78, 91, 45, 34, 8, 59, 20, 50, 70, 19, ],
    [34, 34, 69, 1, 72, 26, 99, 39, 55, 19, 91, 64, 71, 64, 71, 91, 40, 6, 97, 88, ],
    [41, 37, 82, 91, 96, 96, 91, 93, 24, 70, 90, 96, 38, 9, 83, 92, 82, 63, 84, 70, ],
    [45, 33, 37, 90, 42, 5, 92, 56, 59, 94, 67, 90, 44, 62, 31, 61, 96, 87, 32, 13, ],
    [72, 47, 66, 7, 80, 37, 42, 11, 43, 12, 86, 73, 73, 3, 93, 34, 76, 64, 53, 76, ],
    [10, 76, 6, 34, 68, 43, 95, 53, 3, 26, 9, 92, 69, 76, 19, 65, 55, 81, 80, 15, ],
    [16, 41, 56, 53, 28, 61, 45, 82, 90, 38, 20, 93, 50, 55, 70, 26, 30, 18, 24, 73, ],
    [14, 83, 58, 26, 5, 66, 10, 45, 50, 85, 71, 23, 80, 98, 74, 84, 64, 5, 15, 58, ],
    [77, 72, 97, 54, 73, 63, 87, 84, 76, 12, 57, 85, 4, 35, 35, 80, 31, 42, 12, 46, ],
    [79, 76, 18, 36, 74, 9, 76, 88, 79, 85, 50, 7, 33, 56, 65, 26, 78, 47, 57, 35, ],
    [3, 28, 4, 19, 61, 40, 97, 1, 1, 39, 10, 80, 60, 72, 34, 51, 43, 36, 94, 5, ],
    [30, 33, 97, 64, 14, 78, 95, 54, 32, 79, 96, 99, 97, 14, 87, 84, 57, 15, 21, 15, ],
    [23, 97, 97, 57, 21, 44, 26, 35, 84, 25, 91, 64, 21, 18, 49, 1, 66, 67, 75, 25, ],
    [61, 4, 18, 89, 40, 63, 78, 10, 21, 46, 35, 1, 42, 85, 20, 77, 15, 28, 23, 53, ],
    [14, 79, 99, 90, 95, 44, 78, 17, 75, 63, 34, 49, 85, 85, 1, 19, 98, 91, 25, 7, ],
    [25, 86, 34, 90, 0, 54, 59, 93, 60, 92, 8, 22, 30, 53, 61, 69, 28, 60, 40, 64, ],
    [6, 33, 98, 86, 73, 7, 35, 74, 12, 24, 35, 56, 2, 21, 0, 90, 22, 27, 66, 75, ],
    [91, 74, 8, 33, 8, 24, 18, 6, 11, 86, 93, 63, 20, 30, 88, 93, 57, 59, 59, 96, ],
];
bestPath:int = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
nodes:int = 0;

def FindShortestPath(currentRoute:int, visited:bool, level:int, lastIndex:int, currentDistance:int):
    global globalMinDistance;
    global nodes;

    if currentDistance > globalMinDistance:
        return;

    if (level == NUMBER_OF_CITIES):

        currentDistance += distanceMatrix[lastIndex][currentRoute[0]];

        if (currentDistance < globalMinDistance):

            globalMinDistance = currentDistance;

            for i in range(0, NUMBER_OF_CITIES):
                bestPath[i] = currentRoute[i];
        
        return;
    
    for i in range (0, NUMBER_OF_CITIES):
        if level == 1:
            print(f"{i},");
        
        if visited[i] == False:
        
            visited[i] = True;
            currentRoute[level] = i;
            nodes += 1;

            newDistance:int = currentDistance + distanceMatrix[lastIndex][i];
            FindShortestPath(currentRoute, visited, level + 1, i, newDistance);

            visited[i] = False;
        
    

def Start():
    print("started");
    global globalMinDistance;

    startTimeInMS:int = time.time();
    currentRoute:int = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19];
    visited:bool = [True,False,False,False,False, False,False,False,False,False, False,False,False,False,False, False,False,False,False,False, ];
    currentRoute[0] = 0;
    
    FindShortestPath(currentRoute, visited, 1, 0, 0);

    print(f"min distance: {globalMinDistance}");
    print(f"best route: {bestPath[0]}");

    for i in range(1, NUMBER_OF_CITIES):

        print(f"to {bestPath[i]}");
    
    endTimeInMS:int = time.time();
    print(f"time in ms: {endTimeInMS - startTimeInMS}");
    print(f"nodes: {nodes}");

Start();
print("done");
input("____");
