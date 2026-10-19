BALL_SIZE=20
BALL_SPEED = 250
PADDLE_HEIGHT=125
PADDLE_WIDTH=2*BALL_SIZE
PADDLE_SPEED = BALL_SPEED
DIGIT_SIZE = BALL_SIZE


w=love.graphics.getWidth()
ball_x=0
ball_y=0
ball_dx=-BALL_SPEED
ball_dy=BALL_SPEED
paddle_left_y = 0
paddle_right_y = 0
paddle_left_x=PADDLE_WIDTH
paddle_right_x=w-2*PADDLE_WIDTH
score_left=0
score_right=0


digits = { 
   [0]= {{1,1,1}, {1,0,1}, {1,0,1}, {1,0,1}, {1,1,1},},
   [1]= {{1,1,0}, {0,1,0}, {0,1,0}, {0,1,0}, {1,1,1},},
   [2]= {{1,1,1}, {0,0,1}, {0,1,0}, {1,0,0}, {1,1,1},},
   [3]= {{1,1,1}, {0,0,1}, {1,1,1}, {0,0,1}, {1,1,1},},
   [4]= {{1,0,1}, {1,0,1}, {1,1,1}, {0,0,1}, {0,0,1},},
   [5]= {{1,1,1}, {1,0,0}, {1,1,1}, {0,0,1}, {1,1,1},},
   [6]= {{1,1,1}, {1,0,0}, {1,1,1}, {1,0,1}, {1,1,1},},
   [7]= {{1,1,1}, {0,0,1}, {0,1,0}, {1,0,0}, {1,0,0},},
   [8]= {{1,1,1}, {1,0,1}, {1,1,1}, {1,0,1}, {1,1,1},},
   [9]= {{1,1,1}, {1,0,1}, {1,1,1}, {0,0,1}, {1,1,1},},
}


function render_digit(digit,x,y)
    for cell_y,row in ipairs(digit) do 
        for cell_x,cell in ipairs(row) do 
            if cell~=0 then
                love.graphics.rectangle("fill",x+(cell_x-1)*DIGIT_SIZE,y+(cell_y-1)*DIGIT_SIZE,DIGIT_SIZE,DIGIT_SIZE)
            end
        end
    end
end


function love.load()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    paddle_left_y=h/2-PADDLE_HEIGHT*0.5
    paddle_right_y=h/2-PADDLE_HEIGHT*0.5
    ball_x=w/2
    ball_y=h/2
end 


function love.draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
   --love.graphics.setColor(0,1,0)
    love.graphics.circle("fill",ball_x,ball_y,BALL_SIZE)
    love.graphics.rectangle("fill",paddle_left_x,paddle_left_y,PADDLE_WIDTH,PADDLE_HEIGHT)
    love.graphics.rectangle("fill",paddle_right_x,paddle_right_y,PADDLE_WIDTH,PADDLE_HEIGHT)
    local n = 51
    local segment_length = h/n
    love.graphics.setLineWidth(2)
    for i = 0,n-1 do
        if i%2==0 then 
            love.graphics.line(w/2,i*segment_length,w/2,(i+1)*segment_length)
        end
    end
    render_digit(digits[score_left],w/2-5*DIGIT_SIZE,2*DIGIT_SIZE)
    render_digit(digits[score_right],w/2+2*DIGIT_SIZE,2*DIGIT_SIZE)
end


function love.update(dt)
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local ball_next_x = ball_x+ball_dx*dt
    if 
            (paddle_left_y<=ball_y+BALL_SIZE
            and ball_y-BALL_SIZE <paddle_left_y+PADDLE_HEIGHT
            and ball_next_x-BALL_SIZE<paddle_left_x+PADDLE_WIDTH
            and ball_x-BALL_SIZE >= paddle_left_x+PADDLE_WIDTH)
        or  
            (paddle_right_y<=ball_y+BALL_SIZE
            and ball_y-BALL_SIZE<paddle_right_y+PADDLE_HEIGHT
            and ball_next_x+BALL_SIZE>=paddle_right_x
            and ball_x+BALL_SIZE < paddle_right_x)
    then
        ball_dx=-ball_dx
    elseif ball_next_x-BALL_SIZE<0 then
        score_right=score_right+1
        ball_x=w/2
        ball_y=h/2
        ball_dx=BALL_SPEED
        ball_dy=BALL_SPEED
    elseif ball_next_x+BALL_SIZE >=w then
        score_left=score_left+1
        ball_x=w/2
        ball_y=h/2
        ball_dx=-BALL_SPEED
        ball_dy=BALL_SPEED
    else
        ball_x=ball_next_x
    end
    local ball_next_y = ball_y+ball_dy*dt
    if ball_next_y-BALL_SIZE<0 or ball_next_y+BALL_SIZE >=h then
        ball_dy=-ball_dy
    else
        ball_y=ball_next_y
    end
    if love.keyboard.isDown("s") then 
        local paddle_left_ny = paddle_left_y + PADDLE_SPEED*dt
        if paddle_left_ny + PADDLE_HEIGHT < h then
            paddle_left_y=paddle_left_ny
        end
    end
    if love.keyboard.isDown("w") then
        local paddle_left_ny = paddle_left_y - PADDLE_SPEED*dt
        if paddle_left_ny > 0 then
            paddle_left_y=paddle_left_ny
        end
    end
    if love.keyboard.isDown("down") then 
        local paddle_right_ny = paddle_right_y + PADDLE_SPEED*dt
        if paddle_right_ny + PADDLE_HEIGHT < h then
            paddle_right_y=paddle_right_ny
        end
    end
    if love.keyboard.isDown("up") then
        local paddle_right_ny = paddle_right_y - PADDLE_SPEED*dt
        if paddle_right_ny > 0 then
            paddle_right_y=paddle_right_ny
        end
    end
    --ball_x=ball_x+ball_dx*dt
    --ball_y=ball_y+ball_dy*dt
end




