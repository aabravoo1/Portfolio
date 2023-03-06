window.addEventListener('load', () => maze.init());

const maze = {
    init(){
        const body = document.body;
        const header = this.GenerateHeader("Maze", "by Andrés Bravo");
        const main = this.GenerateMain();
        const footer = this.GenerateFooter("© 2022 by Andrés Bravo", );

        body.appendChild(header);
        body.appendChild(main);
        body.appendChild(footer);

        //this.maze = localMaze;
        this.maze = remoteMaze;

        this.NewMaze(7,7);

    },
    GenerateMain(){
        const main = document.createElement('main');
        const limiter = this.ElementWithClasses("div", "main limiter");
        
        //limiter.innerText = "This is the main";
        const cellFieldset = this.GenerateMazeFieldset();
        const controlFieldset = this.GenerateControlFieldset();
        limiter.appendChild(cellFieldset);
        limiter.appendChild(controlFieldset);

        main.appendChild(limiter);

        return main;
    },

    GenerateControlFieldset(){
        const controls = this.GenerateControls();

        const fieldset = this.MakeFieldset("Controls");
        const communications = this.MakeFieldset("Communications");
        const p = document.createElement("p");
        p.id = communications;

        communications.appendChild(p);
        fieldset.appendChild(controls);
        fieldset.appendChild(communications);
        

        return fieldset;
    },

    GenerateControls(){
        const controls = this.ElementWithClasses("div","control-holder square-holder");
        const sizer = this.ElementWithClasses("div", "square-sizer");
        controls.appendChild(sizer);
        const content = this.ElementWithClasses("div", "control-content square-content");
        sizer.appendChild(content);

        const arrowUp = this.ElementWithClasses("div","direction-arrow up");
        content.appendChild(this.ElementWithClasses("div","direction-spacer"))
        content.appendChild(arrowUp);
        content.appendChild(this.ElementWithClasses("div","direction-spacer"))
        
        const arrowLeft = this.ElementWithClasses("div","direction-arrow left");
        content.appendChild(arrowLeft);
        const player = this.ElementWithClasses("div","player-symbol direction-spacer");
        content.appendChild(player);
        const arrowRight = this.ElementWithClasses("div","direction-arrow right");
        content.appendChild(arrowRight);
        
        content.appendChild(this.ElementWithClasses("div","direction-spacer"))
        const arrowDown = this.ElementWithClasses("div","direction-arrow down");
        content.appendChild(arrowDown);
        content.appendChild(this.ElementWithClasses("div","direction-spacer"))
        
        arrowUp.addEventListener("click", () => this.MazeMove(0,-1));
        arrowRight.addEventListener("click", () => this.MazeMove(1,0));
        arrowLeft.addEventListener("click", () => this.MazeMove(-1,0));
        arrowDown.addEventListener("click", () => this.MazeMove(0,1));
        player.addEventListener("click", () => this.Solve(0,0));
        
        return controls;
    },

    GenerateMazeFieldset(){
        const fieldset = this.MakeFieldset("Maze");
        const field = this.ElementWithClasses("div","field");
        fieldset.appendChild(field);

        const sizebar = this.GenerateSizebar();
        fieldset.appendChild(sizebar);

        return fieldset;
    },

    GenerateSizebar(){
        const sizebar = this.ElementWithClasses("div","sizebar");
        const btnSmall = this.GenerateButton("Small", "btn-small");
        const btnMedium = this.GenerateButton("Medium", "btn-medium");
        const btnLarge = this.GenerateButton("Large", "btn-large");
        const btnHuge = this.GenerateButton("Huge", "btn-huge");
        
        btnSmall.addEventListener("click", () => this.NewMaze(7,7));
        btnMedium.addEventListener("click",() => this.NewMaze(13,13));
        btnLarge.addEventListener("click",() => this.NewMaze(25,25));
        btnHuge.addEventListener("click",() => this.NewMaze(49,49));

        sizebar.appendChild(btnSmall);
        sizebar.appendChild(btnMedium);
        sizebar.appendChild(btnLarge);
        sizebar.appendChild(btnHuge);

        return sizebar;
    },

    GenerateButton(text, id){
        const button = document.createElement("button");
        button.type = "button";
        button.innerText = text;
        if(id) 
            button.id = id;
        return button;
    },

    MakeFieldset(title){
        const fieldset = document.createElement("fieldset");
        const legend = document.createElement("legend");
        legend.innerText = title;

        fieldset.appendChild(legend);

        return fieldset;
    },

    GenerateHeader(title, subtitle){
        const header = document.createElement('header');
        const limiter = this.ElementWithClasses("div", "header limiter");
        
        const h1 = document.createElement('h1');
        h1.innerText = title;
        const h2 = document.createElement('h2');
        h2.innerText = subtitle;

        limiter.appendChild(h1);
        limiter.appendChild(h2);

        header.appendChild(limiter);

        return header;
    },

    GenerateFooter(text){
        const footer = document.createElement('footer');
        const limiter = this.ElementWithClasses("div", "footer limiter");
        
        limiter.innerText = text;

        footer.appendChild(limiter);

        return footer;
    },

    GenerateField(width, height){
        const oldField = document.querySelector(".field");
        const newField = this.ElementWithClasses("div","field");

        for (let row = 0; row < height; row++) {
            newField.appendChild(this.GenerateRow(width, row));
        }
        oldField.replaceWith(newField);
        document.querySelectorAll('.row>div').forEach(element => element.style.width = 'calc(100% / '+width+')');
    },

    GenerateRow(width, rowIndex){
        const row = this.ElementWithClasses("div","row");
        for(let column = 0; column  < width; column++){
            row.appendChild(this.GenerateCell(rowIndex,column));
        }
        return row;
    },

    GenerateCell(row,column){
        const squareHolder = this.ElementWithClasses("div", "square-holder");
        const squareSizer = this.ElementWithClasses("div", "square-sizer");
        const cell = this.ElementWithClasses("div","square-content cell");

        cell.dataset.x = column;
        cell.dataset.y = row;

        squareHolder.appendChild(squareSizer);
        squareSizer.appendChild(cell);

        return squareHolder;
    },

    async NewMaze(width,height){
        this.GenerateField(width,height);
        var width = width;
        var height = height;
        const {playerX, playerY} = await this.maze.generate(width,height);
        
        this.positionPlayer(playerX, playerY);
    },

    ElementWithClasses(elementType, classNames){
        const element = document.createElement(elementType);
        for (let className of classNames.split(" ")) {
            element.classList.add(className);  
        }
        return element;
    },

    positionPlayer(x, y){
        this.playerX = x;
        this.playerY = y;
        const playerCell = document.querySelector('[data-x = "'+x+'"][data-y = "'+y+'"]');
        playerCell.classList.remove("cell");
        playerCell.classList.add("wayable");//teacher said "floor" but i think is wayable
        
        const oldPlayer = document.querySelector('.player-symbol.square-content');//selects that it has both of them AND
        if(oldPlayer){
            //alert("player found");
            oldPlayer.classList.remove("player-symbol");
        }
        
        playerCell.classList.add("player-symbol");
        //alert('player Y: ' + y);
        
    },

    async MazeMove(dx, dy){
        //alert("Moving player by: "+dx+", "+dy);
        const newX = this.playerX + dx;
        const newY = this.playerY + dy;
        const {code: {cell}} = await this.maze.move(dx,dy);
        
        switch (cell) {
            case 0:
                this.positionPlayer(newX,newY);
                break;
            case 1:
                this.positionPlayer(newX,newY);
                this.ShowPopUp("You won");
                break;
            case 2:
                this.MarkAsWall(newX,newY);
                break;
            default:
                alert("impossible switch value")
                break;
        }
    },

    MarkAsWall(x,y){
        const wallCell = document.querySelector('[data-x = "'+x+'"][data-y = "'+y+'"]');
        wallCell.classList.remove("cell");
        wallCell.classList.add("wall");
    },

    ShowPopUp(message){
        const popUp = this.ElementWithClasses("div", "pop-up")
        const div = document.createElement("div");
        const text = document.createElement("div");
        text.innerText = message;
        const button = this.GenerateButton("Replay","btn");
        const nobutton = this.GenerateButton("No","btn");

        button.addEventListener("click", () => this.Replay());
        nobutton.addEventListener("click", () => this.HidePopUp());
        
        div.appendChild(text);
        div.appendChild(button);
        div.appendChild(nobutton);
        popUp.appendChild(div);
        document.body.appendChild(popUp);
    },

    Replay(){
        this.NewMaze(7,7);
        this.HidePopUp();
    },

    HidePopUp(){
        const popUp = document.querySelector('.pop-up');
        popUp.remove();
        
    },

    direction: [{dx:1,dy:0},
                {dx:-1,dy:0},
                {dx:0,dy:1},
                {dx:0,dy:-1}],
        
    async Solve(dx,dy){
        //alert("you clicked");
        const oldX = this.playerX;
        const oldY = this.playerY;
        for (let iterator of this.direction) {
            //console.log(dx+","+dy+","+iterator.dx+","+iterator.dy);
            if(iterator.dx === -dx && iterator.dy === -dy){
                continue;
            }
            const newX = oldX+iterator.dx;
            const newY = oldY+iterator.dy;
            //const {code: {cell}} = await this.maze.move(iterator.dx,iterator.dy);
            const move = await this.maze.move(iterator.dx,iterator.dy);
            
            //const ret = await this.maze.move(iterator.dx,iterator.dy);
           
            //document.getElementById(communications);
            //console.log(cell);
            switch (move.code.cell){
                case 0:
                    //this.positionPlayer(newX, newY);
                    this.positionPlayer(move.code.playerX, move.code.playerY);
                    //this.positionPlayer(ret.code.playerX, ret.code.playerY);
                    //this.MazeMove(newX,newY);
                    const solved = await this.Solve(iterator.dx,iterator.dy);
                    if(solved){
                        return Promise.resolve(true);
                    }else{
                        //this.MazeMove(-iterator.dx,-iterator.dy);
                        const move2 = await this.maze.move(-iterator.dx,-iterator.dy);
                        //const ret2 = await this.maze.move(-iterator.dx,-iterator.dy)
                        //this.positionPlayer(oldX,oldY);
                        this.positionPlayer(move2.code.playerX,move2.code.playerY);
                        //this.positionPlayer(ret2.code.playerX, ret2.code.playerY);
                        //return false;
                    }
                    break;
                case 2:
                    this.MarkAsWall(newX,newY);
                    //return Promise.resolve(false);
                    break;
                case 1:
                    this.positionPlayer(newX, newY);
                    this.ShowPopUp("Maze Solved");
                    return Promise.resolve(true);
                    break;
                default:
                    console.log("illegal case value")
                    break;
            }
        }
    
        return Promise.resolve(false);
    }

}

const remoteMaze = {
    url: "https://www2.hs-esslingen.de/~melcher/internet-technologien/maze/",
    token: null,

    async generate(width, height){
        const ret = await this.fetchAndDecode(`generate&userid=anbrit00&width=${width}&height=${height}`);
        console.log(ret);
        this.token = ret.token;
        return ret;
    },
    async move(dx,dy){
        return await this.fetchAndDecode(`move&token=${this.token}&dx=${dx}&dy=${dy}`);
    }, 

    async fetchAndDecode(request){
        //const ret = fetch(this.url+"?request="+request).then(response => {response.json()});
        //console.log(ret);
        //return ret;
        return fetch(this.url+"?request="+request).then(response => response.json());
    }
}

const localMaze = {
    playerX: 1,
    playerY: 1,
    //0: ways
    //1: target
    //2: walls
    maze: [
        [2,2,2,2,2,2,2],
        [2,0,0,0,2,0,2],
        [2,0,2,0,2,0,2],
        [2,0,2,0,0,0,2],
        [2,0,2,2,2,0,2],
        [2,0,0,1,2,0,2],
        [2,2,2,2,2,2,2]
    ],
    async generate(width, height){
        this.playerX = 1;
        this.playerY = 1;
        await this.timeout(200);
        return {playerX:this.playerX, playerY:this.playerY};
    },
    async move(dx,dy){
        if(dx < -1 || dx > 1 || dy < -1 || dy > 1 ){
            alert('too big move');
        }
        const newX = this.playerX + dx;
        const newY = this.playerY + dy;
        const cell = this.maze[newY][newX];
        if(cell == 0 || cell == 1){
            this.playerX = newX;
            this.playerY = newY;
        }
        await this.timeout(200);
        return {cell,playerX:this.playerX, playerY:this.playerY};
        /*return new Promise(
            resolve => window.setTimeout(resolve({cell,playerX:this.playerX, playerY:this.playerY}),500)
        );*/ //shorthand for cell, doesnt need value pairs because of javascript rules, {cell,playerX:this.playerX, playerY:this.playerY}    
    },

    async timeout(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
    
    //promise is the form of making the solver slower, it is part of making a function async. window.setTimeout(resolve())

}
