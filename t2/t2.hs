import Text.Printf

type Point     = (Float,Float)
type Rect      = (Point,Float,Float)
type Circle    = (Point,Float)


-------------------------------------------------------------------------------
-- Paletas
-------------------------------------------------------------------------------

rgbPalette :: Int -> [(Int,Int,Int)]
rgbPalette n = take n $ cycle [(255,0,0),(0,255,0),(0,0,255)]

greenPalette :: Int -> [(Int,Int,Int)] -- desenha as cores dos circulos em RGB
greenPalette n = [(0, j+i*10 ,0) | i <- [0..n], j <- take 5 (iterate (20+) 80) ]

huedPalette :: Int -> [(Int,Int,Int)]
huedPalette n = take n $ cycle [(255,0,0),(255,130,0),(249,255,0),(119,255,0),(0,255,10),(0,255,140),(0,239,255),(0,109,255),(20,0,255),(150,0,255),(255,0,229),(255,0,99)]
-------------------------------------------------------------------------------
-- Geração de retângulos em suas posições
-------------------------------------------------------------------------------

genRectsInLine :: Int -> Int -> [Rect]
genRectsInLine a b = [(( x*(w+gap), y*(h+gap)), w, h) | x <- [0..fromIntegral (a-1)], y <- [0..fromIntegral (b-1)]]
  where (w,h) = (50,50)
        gap = 10

genCirclesInCircle :: Int -> [Circle]
genCirclesInCircle n = [((x+((radius+50.0)*cos(fromIntegral angle)),y+((radius+50.0)*sin(fromIntegral angle))),radius) | angle <- [0,n..360]]
  where (x,y)  = (200,200)
        radius = 15.0

-------------------------------------------------------------------------------
-- Strings SVG
-------------------------------------------------------------------------------

-- Gera string representando retângulo SVG 
-- dadas coordenadas e dimensoes do retângulo e uma string com atributos de estilo
svgRect :: Rect -> String -> String 
svgRect ((x,y),w,h) style = 
  printf "<rect x='%.3f' y='%.3f' width='%.2f' height='%.2f' style='%s' />\n" x y w h style

-- Gera String representando círculos em SVG
svgCircle :: Circle -> String -> String
svgCircle ((x,y),r) style = 
  printf "<circle cx='%.3f' cy='%.3f' r='%.2f' style='%s' />\n" x y r style

-- String inicial do SVG
svgBegin :: Float -> Float -> String
svgBegin w h = printf "<svg width='%.2f' height='%.2f' xmlns='http://www.w3.org/2000/svg'>\n" w h 

-- String final do SVG
svgEnd :: String
svgEnd = "</svg>"

-- Gera string com atributos de estilo para uma dada cor
-- Atributo mix-blend-mode permite misturar cores
svgStyle :: (Int,Int,Int) -> String
svgStyle (r,g,b) = printf "fill:rgb(%d,%d,%d); mix-blend-mode: screen;" r g b

-- Gera strings SVG para uma dada lista de figuras e seus atributos de estilo
-- Recebe uma funcao geradora de strings SVG, uma lista de círculos/retângulos e strings de estilo
svgElements :: (a -> String -> String) -> [a] -> [String] -> String
svgElements func elements styles = concat $ zipWith func elements styles

-------------------------------------------------------------------------------
-- Função principal que gera arquivo com imagem SVG
-------------------------------------------------------------------------------

genCase1 :: IO ()
genCase1 = do
  writeFile "case1.svg" $ svgstrs
  where svgstrs  = svgBegin w h ++ svgfigs ++ svgEnd
        svgfigs  = svgElements svgRect rects (map svgStyle palette)
        rects    = genRectsInLine x y
        palette  = greenPalette x
        (x,y)    = (10,5)
        (w,h)    = (1500,500) -- width,height da imagem SVG

genCase2 :: IO ()
genCase2 = do
  writeFile "case2.svg" $ svgstrs
  where svgstrs = svgBegin w h ++ svgfigs ++ svgEnd
        svgfigs = svgElements svgCircle circles (map svgStyle palette)
        circles = genCirclesInCircle 12
        palette = huedPalette 11
        (w,h)   = (1500,500) -- width,height da imagem SVG