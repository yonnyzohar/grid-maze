# grid-maze

I began looking into creating a maze. Turns out it's a really simple algorithm. You basically need to "carve out" a maze on a tile grid. On every tile you need to figure out which of the surrounding tiles are carvable and then choose one of them. There are rules when deciding which tiles can be carved - mainly that you're not accidentally creating a hall by carving a corridor which is already next to a corridor.
Choosing randomly between the available options will give you a messy maze. However if you remember your latest choice and then increase the probability of choosing the same one again, your maze will look much cleaner.
The second part of the algorithm is what to do when you get stuck. Choosing randomly will quickly get you to a point where you've run out of options. You then need to backtrack to your former steps until you find a step where you can now choose differently than you did the last time.
When you have no more steps to backtrack you know you've carved out your maze 🙂

https://www.facebook.com/watch/?v=443299583642193
