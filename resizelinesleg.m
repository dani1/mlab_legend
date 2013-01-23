function resizelinesleg(hleg, val)
% resizelinesleg(hleg, val)
%
% Input:
% ^^^^^^
% . hleg (optional) : handle to legend / otherwise legend of gcf is used
% . val : float multiplication factor by which lines are resized
% ^^^^^^^^^
% Example:
%   resizelinesleg(0.5) 
%       lines in legend of current figure are reduced
%       by a factor of 0.5 of the previous size.
%
% Author: Daniel Soraruf

    % if only one input : use input as val and hleg from gcf
    if nargin == 1
        val = hleg;
        hleg = findobj(gcf,'Type','axes','Tag','legend');
        if isempty(hleg)
            return
        end
    end
    h  = findobj(hleg, 'type', 'line');
    hm = h(1:2:end); % marker handles
    hl = h(2:2:end); % line   handles
    op = get(hleg, 'position');
    opx = op(3);
    for i = 1 : length(hm)
        ms = get(hm(i), 'marker');
        % check if is only line
        xl = get(hl(i), 'xdata');
        xl(2) = xl(2) * val;
        % the following numbers work rather fine, but can be modified
        xl(1) = 0.4 * xl(1) + 0.6 * val * xl(1);
        set(hl(i), 'xdata', xl);
        set(hm(i), 'xdata', mean(xl))
    end
    ht = findobj(hleg, 'type', 'text');
    xl = get(hl(1), 'xdata');
    rightspace = xl(1)/2;
    for i = 1 : length(ht)
        pos = get(ht(i), 'pos');
        pos(1) = pos(1) * val + rightspace;
        set(ht(i), 'pos', pos);
    end
end
