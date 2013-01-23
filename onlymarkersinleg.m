function onlymarkersinleg(hleg, val)
% onlymarkersinleg(hleg, val)
%
% Input:
% ^^^^^^
% . hleg (optional) : legend handle/ otherwise legend of current fig used
% . val : value/factor by which text position is shifted to the left and
%         lines are reduced if handle has no marker.
% ^^^^^^^^^
% Example : onlymarkersinleg(0.7)
%           shifts text to left by 0.7 and reduces the 'onlylineplots' by
%           this factor.
%
%% Author: Daniel Soraruf

    %if only one input : input = val
    if nargin == 1
        val = hleg;
        hleg = findobj(gcf,'Type','axes','Tag','legend');
    end
    lines = findobj(get(hleg,'children'),'type','line');
    markers=[];
    for i = 1 : length(lines)
        linestyles{i} = 'none';
    end
    m = 1;
    for k = length(lines):-2:1,
        if ~isempty(linestyles),
            set(lines(k),'linestyle',char(linestyles{m}));
        end
        if nargin == 4,
            if ischar(linecolors{m})==1,
                set(lines(k),'color',char(linecolors{m}));
                if ~isempty(markers),
                    set(lines(k-1),'MarkerEdgeColor',char(linecolors{m})); 
                end
            else
                set(lines(k),'color',linecolors{m});
                if ~isempty(markers),
                    set(lines(k-1),'MarkerEdgeColor',linecolors{m});
                end
            end
        end
        m = m+1;
    end

    hc = findobj(hleg, 'type', 'text');
    for i = 1 : length(hc)
        pos = get(hc(i), 'position');
        pos(1) = pos(1) * val;
        set(hc(i), 'position', pos)
    end
    for i = 1 :2: length(lines)
        pos = get(lines(i), 'xdata')
        pos(1) = pos(1) * val;
        set(lines(i), 'xdata', pos)
    end
end
