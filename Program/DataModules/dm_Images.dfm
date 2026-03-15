object dmImages: TdmImages
  Height = 300
  Width = 500
  object ToolbarImageCollection: TImageCollection
    Images = <>
    Left = 56
    Top = 40
  end
  object vilToolbar: TVirtualImageList
    ImageCollection = ToolbarImageCollection
    Width = 32
    Height = 32
    Left = 56
    Top = 120
  end
  object MenuImageCollection: TImageCollection
    Images = <>
    Left = 200
    Top = 40
  end
  object vilMenu: TVirtualImageList
    ImageCollection = MenuImageCollection
    Width = 16
    Height = 16
    Left = 200
    Top = 120
  end
  object DownloadImageCollection: TImageCollection
    Images = <>
    Left = 344
    Top = 40
  end
  object vilDownload: TVirtualImageList
    ImageCollection = DownloadImageCollection
    Width = 16
    Height = 16
    Left = 344
    Top = 120
  end
end
