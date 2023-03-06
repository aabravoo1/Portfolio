window.addEventListener('load', function(){
    tictactoe.start();
});

const tictactoe ={
    board : [], //board for marking x and o
    htmlBoard: [], //board of the html divs
    start(){
        this.board = this.buildBoard();
        this.htmlBoard = this.buildBoard();
        this.buildHtmlBoard();
    },

    buildBoard(){
        const board  = [];
        for(let y=0;y<3;y++){
            board.push([]);
            for(let x=0;x<3;x++){
                board[y].push(' ');
            }
        }
        return board;
    },

    buildHtmlBoard(){
        //const divboard = document.querySelector('#board');
        const divboard = document.getElementById('board');
        divboard.innerHTML = '';

        for(let y = 0; y<3; y++){
            for(let x = 0;x<3;x++){
                let field = document.createElement('div');
                field.classList.add('field');
                field.setAttribute('data-x',x);
                field.setAttribute('data-y',y);

                field.addEventListener('click',event => this.onClick(event));
                divboard.appendChild(field);
                this.htmlBoard[x][y] = field;//changed de x and y values

            }
        }
    },

    onClick(event){
        const clickedField = event.target;
        const x = clickedField.getAttribute('data-x');
        const y = clickedField.getAttribute('data-y');
        
        if(this.board[x][y] !== ' ')
            return;

        if(this.isWin(x,y,'x')){
            setTimeout(()=> {
                if(confirm('Du hast GEWONNEN! - noch ein spiel?')){
                    this.start();
                }
            },200);
            return;
        }
        this.setField(x,y,'x');
        if(this.isFull()){
            setTimeout(()=> {
                if(confirm('unentschieden - noch ein spiel?')){
                    this.start();
                }
            },200);
            return;
        }
    
        if(this.makeMove()){
            setTimeout(()=> {
                if(confirm('Du hast VERLOREN! - noch ein spiel?')){
                    this.start();
                }
            },200);
            return;
        }

    },

    setField(x,y,value){
        this.board[x][y] = value;//add the x or o to the board matrix
        this.htmlBoard[x][y].classList.add(value);//to set a class x or class o so it can be modified in the css
    },

    makeMove(){
        const {maxX, maxY} = this.findBestMove('o'); //find best moves returns an object
        this.setField(maxX, maxY,'o');
        return this.isWin(maxX,maxY,'o');
    },

    findBestMove(player){
        let maxScore = -Number.MAX_VALUE;
        let maxX = 0;
        let maxY = 0;

        for(let y = 0;y<3;y++){
            for(let x=0;x<3;x++){
                if(this.board[x][y] !== ' ')
                    continue;//not checking fields with values
                //further decomposition: field that is called maxScore in the object but with me its just score
                const {maxScore : score} = this.simulateMove(x,y,player); 
                if(score>maxScore){
                    maxScore = score;
                    maxX = x;
                    maxY = y;
                    if(score === 1){
                        return {maxScore,maxX,maxY};
                        //works because the key and value are the same
                        //if not {key:value,key:value,key:value}
                        //we dont need to keep checking if we one
                    }
                }
            }
        }
        if(maxScore == -Number.MAX_VALUE){
            maxScore = 0;
        }
        return {maxScore,maxX,maxY};
    },

    simulateMove(x,y,player){
        if(this.isWin(x,y,player)){
            return {maxScore:1,maxX:x,maxY:y};
        }
        this.board[x][y] = player;
        const {maxScore,maxX,maxY} = this.findBestMove(player == 'o'?'x':'o');//cambiamos los 

        this.board[x][y] = ' ';
        return {maxX,maxY,maxScore:-maxScore} //se cambia el max score porque se calcula el del contrincante no el tuyo

    },

    isWin(x,y,player){
        const previous = this.board[x][y];
        this.board[x][y] = player;

        if(this.winHorizontal(y,player)){
            this.board[x][y] = previous;
            return true;
        }
        if(this.winVertical(x,player)){
            this.board[x][y] = previous;
            return true;
        }
        if(this.winDiagonalL(player)){
            this.board[x][y] = previous;
            return true;
        }
        if(this.winDiagonalR(player)){
            this.board[x][y] = previous;
            return true;
        }

        this.board[x][y] = previous;
        return false;
    },
    winHorizontal(y,player){
        for(let x = 0; x<3;x++){
            if(this.board[x][y] != player)
                return false;
        }
        return true;
    },
    winVertical(x,player){
        for(let y = 0; y<3;y++){
            if(this.board[x][y] != player)
                return false;
        }
        return true;
    },
    winDiagonalL(player){
        for(let p = 0; p<3;p++){
            if(this.board[p][p] != player)
                return false;
        }
        return true;
    },
    winDiagonalR(player){
        for(let p = 0; p<3;p++){
            if(this.board[2-p][p] != player)
                return false;
        }
        return true;
    },
    isFull(){
        for(let y =0;y<3;y++){
            for(let x=0;x<3;x++){
                if(this.board[x][y] === ' ')
                return false;
            }
        }
        return true;
    }
}
