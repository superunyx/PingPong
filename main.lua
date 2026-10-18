BALL_SIZE=20
PADDLE_HEIGHT=125
PADDLE_WIDTH=2*BALL_SIZE
ball_x=10
ball_y=10
ball_dx=1000
ball_dy=1000

function love.draw()
    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
   --love.graphics.setColor(0,1,0)
    love.graphics.circle("fill",ball_x,ball_y,BALL_SIZE)
    love.graphics.rectangle("fill",PADDLE_WIDTH,0,PADDLE_WIDTH,PADDLE_HEIGHT)
    love.graphics.rectangle("fill",w-2*PADDLE_WIDTH,0,PADDLE_WIDTH,PADDLE_HEIGHT)
    local n = 51
    local segment_length = h/n
    love.graphics.setLineWidth(2)
    for i = 0,n-1 do
        if i%2==0 then 
            love.graphics.line(w/2,i*segment_length,w/2,(i+1)*segment_length)
        end
    end
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
    --ball_x=ball_x+ball_dx*dt
    --ball_y=ball_y+ball_dy*dt
end




