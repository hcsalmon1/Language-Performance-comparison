const std = @import("std");
const print = std.debug.print;

const NUMBER_OF_CITIES: usize = 20;
const distanceMatrix = [20][20]u32{
    [20]u32{ 15, 17, 47, 29, 16, 23, 93, 8, 66, 1, 76, 4, 14, 98, 55, 76, 10, 10, 2, 90 },
    [20]u32{ 43, 52, 48, 75, 81, 64, 54, 13, 65, 34, 76, 46, 72, 92, 79, 72, 63, 31, 78, 98 },
    [20]u32{ 7, 12, 52, 96, 24, 13, 3, 37, 28, 92, 78, 91, 45, 34, 8, 59, 20, 50, 70, 19 },
    [20]u32{ 34, 34, 69, 1, 72, 26, 99, 39, 55, 19, 91, 64, 71, 64, 71, 91, 40, 6, 97, 88 },
    [20]u32{ 41, 37, 82, 91, 96, 96, 91, 93, 24, 70, 90, 96, 38, 9, 83, 92, 82, 63, 84, 70 },
    [20]u32{ 45, 33, 37, 90, 42, 5, 92, 56, 59, 94, 67, 90, 44, 62, 31, 61, 96, 87, 32, 13 },
    [20]u32{ 72, 47, 66, 7, 80, 37, 42, 11, 43, 12, 86, 73, 73, 3, 93, 34, 76, 64, 53, 76 },
    [20]u32{ 10, 76, 6, 34, 68, 43, 95, 53, 3, 26, 9, 92, 69, 76, 19, 65, 55, 81, 80, 15 },
    [20]u32{ 16, 41, 56, 53, 28, 61, 45, 82, 90, 38, 20, 93, 50, 55, 70, 26, 30, 18, 24, 73 },
    [20]u32{ 14, 83, 58, 26, 5, 66, 10, 45, 50, 85, 71, 23, 80, 98, 74, 84, 64, 5, 15, 58 },
    [20]u32{ 77, 72, 97, 54, 73, 63, 87, 84, 76, 12, 57, 85, 4, 35, 35, 80, 31, 42, 12, 46 },
    [20]u32{ 79, 76, 18, 36, 74, 9, 76, 88, 79, 85, 50, 7, 33, 56, 65, 26, 78, 47, 57, 35 },
    [20]u32{ 3, 28, 4, 19, 61, 40, 97, 1, 1, 39, 10, 80, 60, 72, 34, 51, 43, 36, 94, 5 },
    [20]u32{ 30, 33, 97, 64, 14, 78, 95, 54, 32, 79, 96, 99, 97, 14, 87, 84, 57, 15, 21, 15 },
    [20]u32{ 23, 97, 97, 57, 21, 44, 26, 35, 84, 25, 91, 64, 21, 18, 49, 1, 66, 67, 75, 25 },
    [20]u32{ 61, 4, 18, 89, 40, 63, 78, 10, 21, 46, 35, 1, 42, 85, 20, 77, 15, 28, 23, 53 },
    [20]u32{ 14, 79, 99, 90, 95, 44, 78, 17, 75, 63, 34, 49, 85, 85, 1, 19, 98, 91, 25, 7 },
    [20]u32{ 25, 86, 34, 90, 0, 54, 59, 93, 60, 92, 8, 22, 30, 53, 61, 69, 28, 60, 40, 64 },
    [20]u32{ 6, 33, 98, 86, 73, 7, 35, 74, 12, 24, 35, 56, 2, 21, 0, 90, 22, 27, 66, 75 },
    [20]u32{ 91, 74, 8, 33, 8, 24, 18, 6, 11, 86, 93, 63, 20, 30, 88, 93, 57, 59, 59, 96 },
};
var nodes: u64 = 0;
var minDistance: u32 = 2147483647;
var bestRoute = [NUMBER_OF_CITIES]u32{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

const RouteData = struct {
    currentRoute: [NUMBER_OF_CITIES]u32,
    visited: [NUMBER_OF_CITIES]bool,
};

fn FindShortestPath(routeData: *RouteData, level: usize, lastIndex: usize, currentDistance: u32) void {
    //if the distance is already higher than the lowest distance found
    if (currentDistance > minDistance) {
        return; //prune
    }

    if (level == NUMBER_OF_CITIES) {
        const START_INDEX = routeData.currentRoute[0];
        const FINAL_DISTANCE = currentDistance + distanceMatrix[lastIndex][START_INDEX]; // return to start
        if (FINAL_DISTANCE < minDistance) {
            minDistance = FINAL_DISTANCE;

            // print("   Set best route: ", .{});
            for (0..NUMBER_OF_CITIES) |i| {
                bestRoute[i] = routeData.currentRoute[i];
                // print("{}, ", .{bestRoute[i]});
            }
            // print("\n", .{});
        }
        return;
    }

    for (0..NUMBER_OF_CITIES) |i| {
        if (routeData.visited[i] == false) {
            routeData.visited[i] = true;
            routeData.currentRoute[level] = @intCast(i);
            nodes += 1;

            const newDistance: u32 = currentDistance + distanceMatrix[lastIndex][i];
            FindShortestPath(routeData, level + 1, i, newDistance);

            routeData.visited[i] = false;
        }
    }
}

fn RunFullRecursive() !void {
    var timer = try std.time.Timer.start();

    var routeData: RouteData = RouteData{
        .currentRoute = [NUMBER_OF_CITIES]u32{ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 },
        .visited = [NUMBER_OF_CITIES]bool{ true, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false },
    };

    FindShortestPath(&routeData, 1, 0, 0);

    print("\nmin dist: {}\n", .{minDistance});

    const elapsed_time = timer.read();

    print("best route:", .{});

    for (0..NUMBER_OF_CITIES) |i| {
        print(" to {}", .{bestRoute[i]});
    }
    print("\n", .{});
    print("time: {s}\n", .{std.fmt.fmtDuration(elapsed_time)});

    print("Nodes: {}\n", .{nodes});
}

pub fn main() !void {
    try RunFullRecursive();

    print("____\n", .{});

    //This stops the program closing instantly.
    const reader = std.io.getStdIn().reader();
    _ = try reader.readByte();
}
