BALL_SIZE=20
BALL_SPEED = 750
PADDLE_HEIGHT=125
PADDLE_WIDTH=2*BALL_SIZE
PADDLE_SPEED = BALL_SPEED/2
DIGIT_SIZE = BALL_SIZE



ball_x=10
ball_y=10
ball_dx=BALL_SPEED
ball_dy=BALL_SPEED
paddle_left_y = 0
paddle_right_y = 0

digits = {
    --0
    {
        {1,1,1},
        {1,0,1},
        {1,0,1},
        {1,0,1},
        {1,1,1},
    },
    --1
    {
        {1,1,0},
        {0,1,0},
        {0,1,0},
        {0,1,0},
        {1,1,1},
    },
    --2
    {
        {1,1,1},
        {0,0,1},
        {0,1,0},
        {1,0,0},
        {1,1,1},
    },
    --3
    {
        {1,1,1},
        {0,0,1},
        {1,1,1},
        {0,0,1},
        {1,1,1},
    },
    --4
    {
        {1,0,1},
        {1,0,1},
        {1,1,1},
        {0,0,1},
        {0,0,1},
    },
    --5
    {
        {1,1,1},
        {1,0,0},
        {1,1,1},
        {0,0,1},
        {1,1,1},
    },
    --6
    {
        {1,1,1},
        {1,0,0},
        {1,1,1},
        {1,0,1},
        {1,1,1},
    },
    --7
    {
        {1,1,1},
        {0,0,1},
        {0,1,0},
        {1,0,0},
        {1,0,0},
    },
    --8
    {
        {1,1,1},
        {1,0,1},
        {1,1,1},
        {1,0,1},
        {1,1,1},
    },
    --9
    {
        {1,1,1},
        {1,0,1},
        {1,1,1},
        {0,0,1},
        {1,1,1},
    },
}

function render_digit(digit,x,y)
    for cell_y,row in ipairs(digit) do 
        for cell_x,cell in ipairs(row) do 
            if cell~=0 then
                love.graphics.rectangle("fill",x+cell_x*DIGIT_SIZE,y+cell_y*DIGIT_SIZE,DIGIT_SIZE,DIGIT_SIZE)
            end
        end
    end
end

function love.draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
   --love.graphics.setColor(0,1,0)
    love.graphics.circle("fill",ball_x,ball_y,BALL_SIZE)
    love.graphics.rectangle("fill",PADDLE_WIDTH,paddle_left_y,PADDLE_WIDTH,PADDLE_HEIGHT)
    love.graphics.rectangle("fill",w-2*PADDLE_WIDTH,paddle_right_y,PADDLE_WIDTH,PADDLE_HEIGHT)
    local n = 51
    local segment_length = h/n
    love.graphics.setLineWidth(2)
    for i = 0,n-1 do
        if i%2==0 then 
            love.graphics.line(w/2,i*segment_length,w/2,(i+1)*segment_length)
        end
    end
    render_digit(digits[10],0,0)
    render_digit(digits[8],3*DIGIT_SIZE+DIGIT_SIZE,0)
end

function love.update(dt)
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local ball_next_x = ball_x+ball_dx*dt
    if ball_next_x<0 or ball_next_x+BALL_SIZE >=w then
        ball_dx=-ball_dx
    else
        ball_x=ball_next_x
    end
    local ball_next_y = ball_y+ball_dy*dt
    if ball_next_y<0 or ball_next_y+BALL_SIZE >=h then
        ball_dy=-ball_dy
    else
        ball_y=ball_next_y
    end
    if love.keyboard.isDown("s") then 
        paddle_left_y = paddle_left_y + PADDLE_SPEED*dt
    end
    if love.keyboard.isDown("w") then
        paddle_left_y = paddle_left_y - PADDLE_SPEED*dt
    end
    --ball_x=ball_x+ball_dx*dt
    --ball_y=ball_y+ball_dy*dt
end




