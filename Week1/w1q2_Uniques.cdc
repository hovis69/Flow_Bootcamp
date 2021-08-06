pub struct Canvas {

  pub let width: UInt8
  pub let height: UInt8
  pub let pixels: String

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width
    self.height = height
    // The following pixels
    // 123
    // 456
    // 789
    // should be serialized as
    // 123456789
    self.pixels = pixels
  }
}

pub resource Picture {
  pub let canvas: Canvas
  
  init(canvas: Canvas) {
    self.canvas = canvas
  }
    // this is W1Q1 – Frame it!
    // kept getting errors when using canvas: Canvas
    // from the quest .so removed this and placed fuction 
    // within the Picture resource
    pub fun display(){

        var framed:String = ""
        var currentWidth:UInt8 = 0
        var currentHeight:UInt8 = 0
        var rowStart:Int = 0
        var rowEnd:Int = Int(self.canvas.width)


        while (currentHeight<self.canvas.height+2){
            currentWidth = 0
            if (currentHeight==0 || currentHeight == self.canvas.height+1){
                framed = "+" 
                while (currentWidth<self.canvas.width)
                {
                    framed = framed.concat("-")
                    currentWidth = currentWidth+1 
                }
                framed = framed.concat("+")
            }
            else 
            {
                framed = "|"
                
                framed = framed.concat(self.canvas.pixels.slice(from: rowStart, upTo: rowEnd))
                    
                framed = framed.concat("|")
                rowStart = rowStart + Int(self.canvas.width) 
                rowEnd = rowEnd + Int(self.canvas.width)
            }

        
        log(framed)
        framed = ""
        currentHeight = currentHeight+1
        
        }

    }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }

  return buffer
}
pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]
  let canvasX = Canvas(
    width: 5,
    height: 5,
    pixels: serializeStringArray(pixelsX)
  )
  let letterX <- create Picture(canvas: canvasX)
    log(letterX.display())
  //log(letterX.canvas)
  destroy letterX
}