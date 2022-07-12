function [] = KLT_printItems(app)

app.ListBox.Items(1:length(find(~cellfun(@isempty,app.ListBox.Items)))) = app.ListBox.Items(find(~cellfun(@isempty,app.ListBox.Items)));
app.ListBox.Items = app.ListBox.Items(length(app.ListBox.Items)-999:length(app.ListBox.Items));

end