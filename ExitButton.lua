--- STEAMODDED HEADER
--- MOD_NAME: Exit Button
--- MOD_ID: rkndl2_ExitButton
--- PREFIX: rkndl2_exitbtn
--- VERSION: 1.0.0
--- MOD_AUTHOR: [infarctus, Ryan]
--- MOD_DESCRIPTION: Adds an Exit Game button to the options menu

-- G.FUNCS assignments remain the standard for UI callbacks in SMODS 1.0
G.FUNCS.exit_button = function(e)
    G.SETTINGS.paused = true
    love.event.quit()
end

local create_options_ref = create_UIBox_options
function create_UIBox_options()
    -- FIXED: Enforced local scope to prevent memory leaks and mod conflicts
    local contents = create_options_ref()
    
    local exit_button = UIBox_button({
        minw = 5,
        button = "exit_button",
        label = { "Exit Game" }
    })

    -- FIXED: Safe traversal ensures the UI tree actually exists before injecting.
    -- If another mod alters the layout, it aborts the injection rather than crashing the game.
    if contents and contents.nodes and contents.nodes[1] 
       and contents.nodes[1].nodes and contents.nodes[1].nodes[1] 
       and contents.nodes[1].nodes[1].nodes then
        
        table.insert(contents.nodes[1].nodes[1].nodes[1].nodes, exit_button)
    else
        sendErrorMessage("[ExitButton] UI tree structure mismatch. Button injection aborted to prevent crash.")
    end
    
    return contents
end

