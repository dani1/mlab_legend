function  resizeleg(hleg, val, loc)
% resizeleg(hleg, val, loc)
% Resizes the legend in a plot by a factor of val
% Input:
% ^^^^^^
% . hleg: handle to legend or string 'auto' for legend from current figure
% . val: multiplication factor by which the legend has to be
%         increased or reduced in size e.g. 0.8
% . loc: border location with fixed position
%        loc from {'up'  |'top'   |'north',
%                 'down' |'bottom'|'south',
%                 'left' |'west',
%                 'right'|'east'}
% ^^^^^^^^^
% Example:
%   resizeleg('auto', 0.7, 'top')
%        reduces the legend in gcf() by a factor of 0.7 in the 
%        y-direction leaving the top border position fixed.
%
% Author: Daniel Soraruf

pause(0.5); % sometimes necessary
if strcmp(hleg, 'auto')
    hleg = findobj(gcf, 'type', 'axes', 'tag', 'legend')
end
loc = lower(loc)
    % pixel units are needed to change the size, who knows why.
    set(hleg, 'units', 'pixel');
    op = get(hleg, 'outerposition');
    if any(strcmp(loc, {'up', 'top', 'north'}))
        op(2) = op(2) + op(4) * (1 - val);
        op(4) = op(4) * val;
    elseif any(strcmp(loc, {'down', 'bottom', 'south'}))
        op(2) = op(2);
        op(4) = op(4) * val;
    elseif any(strcmp(loc, {'left', 'west'}))
        op(1) = op(1);
        op(3) = op(3) * val;
    elseif any(strcmp(loc, {'right', 'east'}))
        op(1) = op(1) + op(3) * (1 - val);
        op(3) = op(3) * val;
    end
    set(hleg, 'outerposition', op);
end
