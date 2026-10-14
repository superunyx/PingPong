ball_size=30
ball_x=10
ball_y=10
ball_dx=500
ball_dy=500

function love.draw()
   --love.graphics.setColor(0,1,0)
    love.graphics.circle("fill",ball_x,ball_y,ball_size)
end

function love.update(dt)
    w = love.graphics.getWidth()
    h = love.graphics.getHeight()
    local ball_next_x = ball_x+ball_dx*dt
    if ball_next_x<0 or ball_next_x+ball_size >=w then
        ball_dx=-ball_dx
    else
        ball_x=ball_next_x
    end
    local ball_next_y = ball_y+ball_dy*dt
    if ball_next_y<0 or ball_next_y+ball_size >=h then
        ball_dy=-ball_dy
    else
        ball_y=ball_next_y
    end
    ball_x=ball_x+ball_dx*dt
    ball_y=ball_y+ball_dy*dt
end




