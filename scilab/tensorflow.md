
## mostrar una grafica contfvis

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>grafica</title>
    <!-- Import TensorFlow.js -->
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@1.0.0/dist/tf.min.js"></script>
    <!-- Import tfjs-vis -->
    <script src="https://cdn.jsdelivr.net/npm/@tensorflow/tfjs-vis@1.0.2/dist/tfjs-vis.umd.min.js"></script>

</head>

<body>

</body>
<script>
    let values = [
        { x: 1, y: 3 },
        { x: 2, y: 6 },
        { x: 3, y: 9 },
        { x: 4, y: 16 },
        { x: 5, y: 25 },
        { x: 6, y: 36 },
        { x: 7, y: 49 },
        { x: 8, y: 64 },
        { x: 9, y: 81 },
        { x: 10, y: 100 },
        { x: 11, y: 121 },
    ]
    tfvis.render.scatterplot(
        { name: 'funcion cuadratica' },
        { values },
        {
            xLabel: 'x',
            yLabel: 'y=x^2',
            height: 300
        }
    );
</script>

</html>
```
## referencias
[Graficar con TF](https://js.tensorflow.org/api_vis/1.5.1/)
[TF con js - ejemplos](https://www.tensorflow.org/js/demos?hl=es-419)
[Maching learning](https://developers.google.com/machine-learning/crash-course/classification/thresholding?hl=es-419)