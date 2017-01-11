######################S Bonner###############################################
[void][reflection.assembly]::LoadWithPartialName("System.Windows.Forms")
 
$file = (get-item 'path.png')

 
$img = [System.Drawing.Image]::Fromfile($file);

[System.Windows.Forms.Application]::EnableVisualStyles();
$form = new-object Windows.Forms.Form
$form.Text = "text"
$form.Width = $img.Size.Width;
$form.Height = $img.Size.Height;
$pictureBox = new-object Windows.Forms.PictureBox
$pictureBox.Width = $img.Size.Width;
$pictureBox.Height = $img.Size.Height;
 
$pictureBox.Image = $img;
$form.controls.add($pictureBox)
$form.Add_Shown( { $form.Activate() } )
$form.ShowDialog()
#$form.Show();