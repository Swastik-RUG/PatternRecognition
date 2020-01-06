function [prototypeList, error_rate_by_epochs, prediction_list] = myLVQ1(data, prototypes, class_labels, learning_rate)
    % commonly used variables and return variables
    data_size = size(data,1);
    prototypeList = [];
    relevance_learning_rate = 0.0001;
    relevance1 = 0.5;
    relevance2 = 0.5;
    error_ratio = 99;
    predictions = [];
    relevances = [];
    error_rate_by_epochs = [];
    previous_epoch_errors = 9999;
    % Training Block
    % Check if class_labels is empty, used to determine training or testing
    % phase
    if (~isempty(class_labels))
        % Iterate the loop until error ratio for the last few cycles does
        % not reduce significantly
        while (error_ratio >=1 || error_ratio <0.9990)
            % Counter to track the number of classification errors made in
            % the current iteration or learning cycle
            epoch_errors = 0;
            % Iterate over the training data
            for i=1:data_size
                % Get the ith row on which the model is being trained upon
                cur_sample_row = data(i,:);
                % Find the euclidian distance between the training point
                % and the prototypes with relevance.
                cur_sample_dist = pdist2(cur_sample_row, prototypes(:,1:2), 'squaredeuclidean');
                % Find the prototype who has the minimum distance to the
                % sample point
                [min_dist_to_prototype, min_indx] = min(cur_sample_dist);
                % Predict the class label of the sample point using the
                % prototype computed in the previous step.
                prediction = prototypes(min_indx, 3);
                % Check if the predicted label matches with the expected
                % class label
                expected_label = class_labels(i);
                % If the prediction is correct increase or strengthen the
                % bias of the prototype towards the sample point.
                if(prediction == expected_label)
                    % Move the prototype closer to the sample point
                    prototypes(min_indx, 1:2) = prototypes(min_indx,1:2) + learning_rate * (cur_sample_row - prototypes(min_indx,1:2));
                    % Compute the new relevances
                   % relevance1 = relevance1 - relevance_learning_rate * abs(cur_sample_row(1)-prototypes(min_indx));
                  %  relevance2 = relevance2 - relevance_learning_rate * abs(cur_sample_row(1)-prototypes(min_indx));
                    % A restriction to not allow relevance 1 from dropping
                    % below 0
                  %  if relevance1 < 0
                   %     relevance1 = 0;
                   % end
                    % Normalize the releavances to be between 0 - 1
                   % relevance1 = relevance1/(relevance1+relevance2);
                  %  relevance2 = relevance2/(relevance1+relevance2);
                else
                    % Move the prototype away from the sample point as the
                    % prediction was wrong in this scenario
                    prototypes(min_indx, 1:2) = prototypes(min_indx,1:2) - learning_rate * (cur_sample_row - prototypes(min_indx,1:2));
                    % Compute the new relevances
                 %   relevance1 = relevance1 + relevance_learning_rate * abs(cur_sample_row(1)-prototypes(min_indx));
                  %  relevance2 = relevance2 + relevance_learning_rate * abs(cur_sample_row(1)-prototypes(min_indx));
                    % A restriction to not allow relevance 1 from dropping
                    % below 0
                 %   if relevance1 < 0
                 %       relevance1 = 0;
                %    end
                    % Normalize the releavances to be between 0 - 1
                   % relevance1 = relevance1/(relevance1+relevance2);
                   % relevance2 = relevance2/(relevance1+relevance2);
                    epoch_errors = epoch_errors + 1;
                end            
            end
            % Store the relevance values that were obatined in each epoch
            % step.
          %  relevances = [relevances, [relevance1; relevance2]];
            % Compute the error rate, i.e total classification errors
            % caused in a given epoch step to the size of training data
            error_rate = epoch_errors / data_size;
            % Store the error rate for each epoch step.
            error_rate_by_epochs = [error_rate_by_epochs; error_rate];

            % Run for atleast 2 iterations
            % If the error rate obtained is approximately equal to the previous
            % few iterations, we assume that the training has reached a stable
            % state and this terminates the while loop
            if size(error_rate_by_epochs,1) <2
                error_ratio = 99;
            else
                % Compute the new error ratio by looking comparing the
                % error rate obtained in last 70 - 85% of all the error
                % ratio generated by their epoch steps
                size_epoch_error_list = size(error_rate_by_epochs,1);
                error_ratio = mean(error_rate_by_epochs(floor(size_epoch_error_list*0.7):floor(size_epoch_error_list*0.85)))/mean(error_rate_by_epochs(floor(size_epoch_error_list*0.85):size_epoch_error_list));
            end
            
            % If the error rate for a given epoch step has saturated with
            % the previous epoch step, stop the iteration early as further
            % training will not yeild significant gain.
            if abs(previous_epoch_errors/data_size - epoch_errors/data_size) < 0.001
                fprintf("Epoch errors reached Saturation....Early Termination\n");
                break;
            end
            previous_epoch_errors = epoch_errors;
            % Save the new prototype positions after training
            prototypeList = prototypes;
            % Save the predictions made; not required to return for training
            prediction_list = predictions;
        end
    end
    
    % Prediction Block / Testing
    if isempty(class_labels)
        % Stores the predictions made over the test data
        predictions = [];
        for j=1:data_size
            % Get the current sample point for testing the model.
            cur_sample_row = data(j,:);
            % Determine the euclidian distance between the sample point to
            % the prototypes determined from the training phase.
            cur_sample_dist = pdist2(cur_sample_row, prototypes(:,1:2), 'squaredeuclidean');
            % Find the prototype which has the least distance from the
            % sample point
            [min_dist_to_prototype, min_indx] = min(cur_sample_dist);
            % Predict the class label of the sample point using the
            % prototype determined in the previous step
            predictions(j,1) = prototypes(min_indx, 3);
        end
        % Store the predictions made in a list to return back to the
        % calling method.
        prediction_list = predictions;
    end
    
    % Determines the euclidian distance between a sample point and the
    % prototype with relavances.
    function dist = find_euclidian_dist(sample_point, prototypes, relevance1, relevance2)
        dist = ((relevance1 * (sample_point(1) - prototypes(:,1)).^2) + (relevance2 * (sample_point(2) - prototypes(:,2)).^2))';
    end
    
end