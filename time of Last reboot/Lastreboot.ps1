get-eventlog system | 
    ? { $_.EventId -eq 6009 } | 
    select -first 1 | 
    % { $_.TimeGenerated }