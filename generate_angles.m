% Generates angles in the safe zone for the dobot
function angles = generate_angles()

    angles = zeros(3,1);
    q1sd = 60;
    angles(1) = normrnd(0, q1sd);
    angles(2) = rand()*90-5;
    angles(3) = rand()*87+5;
    
    while abs(angles(1)) > 100
        angles(1) = normrnd(0, q1sd);
    end
    
    if angles(2) <= 40
        while angles(3) > (4/5)*angles(2)+60
            angles(3) = rand()*87+5;
        end
    else 
         while angles(3) < angles(2)-35
            angles(3) = rand()*87+5;
         end
    end
end
