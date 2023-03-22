function key_press_callback_images(src, event, image_handles)
    switch event.Key
        case '1'
            set_visibility(image_handles, [1 0 0 0]);
        case '2'
            set_visibility(image_handles, [0 1 0 0]);
        case '3'
            set_visibility(image_handles, [0 0 1 0]);
        case '4'
            set_visibility(image_handles, [0 0 0 1]);
    end
end

function set_visibility(image_handles, visibility)
    for i = 1:length(image_handles)
        if visibility(i)
            set(image_handles(i), 'Visible', 'on');
        else
            set(image_handles(i), 'Visible', 'off');
        end
    end
end
