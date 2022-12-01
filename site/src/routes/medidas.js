var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idBarril", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
})

router.get("/carregarTempIdeal/:idBarril", function (req, res) {
    medidaController.carregarTempIdeal(req, res);
});

router.get("/carregarTempFora/:idBarril", function (req, res) {
    medidaController.carregarTempFora(req, res);
});

router.get("/carregarUmidadeIdeal/:idBarril", function (req, res) {
    medidaController.carregarUmidadeIdeal(req, res);
});

router.get("/carregarUmidadeFora/:idBarril", function (req, res) {
    medidaController.carregarUmidadeFora(req, res);
});

module.exports = router;