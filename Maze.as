package {
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.utils.*;

	public class Maze extends MovieClip {

		var NORTH: int = 1;
		var EAST: int = 2;
		var SOUTH: int = 3;
		var WEST: int = 4;
		var pastPositions: Array = [];
		var arr: Array = [];
		var bob: Wall = new Wall();
		var btm_layer: MovieClip = new MovieClip();
		var top_layer: MovieClip = new MovieClip();
		var pos: Point = new Point(20, 0);

		var b: Block = new Block();


		public function Maze() {

			stage.scaleMode = "noScale";
			stage.addChild(top_layer);
			stage.addChild(btm_layer);
			var w: int = stage.stageWidth / b.width;
			var h: int = stage.stageHeight / b.height;
			for (var row: int = 0; row < h; row++) {
				arr.push([]);
				for (var col: int = 0; col < w; col++) {
					b = new Block();
					b.x = b.width * col;
					b.y = b.height * row;
					btm_layer.addChild(b);
					arr[row][col] = b;
				}
			}
			stage.addChild(bob);
			beginMaze(pos, SOUTH);

			// constructor code
		}


		function beginMaze(p: Point, lastDir: int): void {

			bob.x = p.x * bob.width;
			bob.y = p.y * bob.height;

			if (arr[p.y][p.x]) {
				btm_layer.removeChild(arr[p.y][p.x]);
				arr[p.y][p.x] = null;
			}

			//////////////////////////
			//for a maze wall to be carved, we need it to exist and for the following block to also exist
			//we also need to make sure that if we are going in a direction, then there are walls on our left and right
			//////
			var possibleDirs: Array = [];
			if (
				//can i go north
				(arr[p.y - 1] && arr[p.y - 1][p.x]) &&
				(arr[p.y - 2] && arr[p.y - 2][p.x]) &&
				//is there a wall to the left
				(arr[p.y - 1][p.x - 1]) && (arr[p.y - 2][p.x - 1]) &&
				//i there a wall to the right
				(arr[p.y - 1][p.x + 1]) && (arr[p.y - 2][p.x + 1])
			) {
				possibleDirs.push(NORTH);
			}
			if (
				//can i go east
				(arr[p.y] && arr[p.y][p.x + 1]) &&
				(arr[p.y] && arr[p.y][p.x + 2]) &&
				//is there a wall to the left
				(arr[p.y - 1] && arr[p.y - 1][p.x + 1]) && (arr[p.y - 1] && arr[p.y - 1][p.x + 2]) &&
				//is there a wall to the right
				(arr[p.y + 1] && arr[p.y + 1][p.x + 1]) && (arr[p.y + 1] && arr[p.y + 1][p.x + 2])
			) {
				possibleDirs.push(EAST);
			}
			if ((arr[p.y + 1] && arr[p.y + 1][p.x]) &&
				(arr[p.y + 2] && arr[p.y + 2][p.x]) &&
				//is there a wall to the left
				(arr[p.y + 1] && arr[p.y + 1][p.x + 1]) && (arr[p.y + 2] && arr[p.y + 2][p.x + 1]) &&
				//is there a wall to the right
				(arr[p.y + 1] && arr[p.y + 1][p.x - 1]) && (arr[p.y + 2] && arr[p.y + 2][p.x - 1])
			) {
				possibleDirs.push(SOUTH);
			}
			if (
				(arr[p.y] && arr[p.y][p.x - 1]) &&
				(arr[p.y] && arr[p.y][p.x - 2]) &&
				//is there a wall to the left
				(arr[p.y - 1] && arr[p.y - 1][p.x - 1]) && (arr[p.y - 1] && arr[p.y - 1][p.x - 2]) &&
				//is there a wall to the right
				(arr[p.y + 1] && arr[p.y + 1][p.x - 1]) && (arr[p.y + 1] && arr[p.y + 1][p.x - 2])
			) {
				possibleDirs.push(WEST);
			}

			if (possibleDirs.length == 0) {

				setTimeout(function (): void {
					pos = pastPositions.pop();
					if (pos) {
						beginMaze(pos, 0);
					} else {
						trace("DONE!");
						for (var i: int = 0; i < arr.length; i++) {
							var rnd: int = Math.floor(Math.random() * arr[i].length);
							if (arr[arr.length - 2][rnd] == null) {
								btm_layer.removeChild(arr[arr.length - 1][rnd]);
								arr[arr.length - 1][rnd] = null;
								break;
							}
						}

					}

				}, 10)

			} else {
				//this makes the walls straight
				if (possibleDirs.indexOf(lastDir) != -1) {

					for (var h: int = 0; h < 10; h++) {
						possibleDirs.push(lastDir);
					}
				}

				var selectedDir: int = possibleDirs[Math.floor(Math.random() * possibleDirs.length)];
				if (selectedDir == NORTH) {
					p.y--;
				}
				if (selectedDir == EAST) {
					p.x++;
				}
				if (selectedDir == SOUTH) {
					p.y++;
				}
				if (selectedDir == WEST) {
					p.x--;
				}
				setTimeout(function (): void {
					pastPositions.push(new Point(p.x, p.y));
					beginMaze(p, selectedDir);
				}, 50)
			}
		}

	}

}