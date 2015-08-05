function tk_drawShapes(shapeInfo,pln)

% xMax = max(shapeInfo.x_r)+2;
% xMin = min(shapeInfo.x_l)-2;
xMax = max(abs([shapeInfo.x_l; shapeInfo.x_r]));
xMin = 0;
numOfBeams=pln.numOfBeams;
shapeOffset=0;
offset=1;
% shapeInfo.zPos = -shapeInfo.zPos;

for m=1:pln.numOfBeams
    
    figure

    for l=1:shapeInfo.numOfShapes(m)

        numOfLines = numel(shapeInfo.shapeIx(shapeInfo.shapeIx == l+shapeOffset));

        subplot(floor(shapeInfo.numOfShapes(m)/2),... 
            ceil(shapeInfo.numOfShapes(m)/2),l)
%         grid on
%         set(gca,'XTick',0:1:xMax)
%         axis([xMin xMax min(shapeInfo.zPos)-pln.bixelWidth/2 ...
%             max(shapeInfo.zPos)+pln.bixelWidth/2])
%         xlim([xMin xMax])
        xlim([0.5 xMax+0.5])
        ylim([offset-0.5 offset+numOfLines-1+0.5])
%         for i=offset:offset+numOfLines-1
%             hold on
%             fill([xMin shapeInfo.x_l(i) shapeInfo.x_l(i) xMin],...
%                 [shapeInfo.zPos(i)-pln.bixelWidth/2 ...
%                 shapeInfo.zPos(i)-pln.bixelWidth/2 ...
%                 shapeInfo.zPos(i)+pln.bixelWidth/2 ...
%                 shapeInfo.zPos(i)+pln.bixelWidth/2],'b')
%             fill([shapeInfo.x_r(i) xMax xMax shapeInfo.x_r(i)],...
%                 [shapeInfo.zPos(i)-pln.bixelWidth/2 ...
%                 shapeInfo.zPos(i)-pln.bixelWidth/2 ...
%                 shapeInfo.zPos(i)+pln.bixelWidth/2 ...
%                 shapeInfo.zPos(i)+pln.bixelWidth/2],'b')
%         end
        
        hold on
        for i=offset:offset+numOfLines-1
            fill([0.5 shapeInfo.x_l(i)+0.5 shapeInfo.x_l(i)+0.5 0.5],...
                [i-1/2 ...
                i-1/2 ...
                i+1/2 ...
                i+1/2],'b')
            fill([shapeInfo.x_r(i)+0.5 xMax+0.5 xMax+0.5 shapeInfo.x_r(i)+0.5],...
                [i-1/2 ...
                i-1/2 ...
                i+1/2 ...
                i+1/2],'b')
        end
        axis ij
        axis tight
        offset = offset + numOfLines;   
    end

    shapeOffset = shapeOffset + shapeInfo.numOfShapes(m);
end

end