function boutKinematicParams = generate_kinematic_feature(boutKine,eyeConv)
boutKinematicParams_pos = boutKine_calc(boutKine,eyeConv,1,10,'batch');
boutKinematicParams_neg = boutKine_calc(cellfun(@(x) -x,boutKine,'un',0),eyeConv,1,10,'batch');
boutKinematicParams = nan(size(boutKinematicParams_pos));
boutKinematicParams(boutKinematicParams_pos(:,48)==0&boutKinematicParams_neg(:,48)==1,:) = boutKinematicParams_pos(boutKinematicParams_pos(:,48)==0&boutKinematicParams_neg(:,48)==1,:);
boutKinematicParams(boutKinematicParams_pos(:,48)==1&boutKinematicParams_neg(:,48)==0,:) = boutKinematicParams_neg(boutKinematicParams_pos(:,48)==1&boutKinematicParams_neg(:,48)==0,:);
newfeature = extractFrequencyDomainFeature(boutKine);
boutKinematicParams = [boutKinematicParams newfeature];
end

