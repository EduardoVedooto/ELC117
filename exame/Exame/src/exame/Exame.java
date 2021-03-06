package exame;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.application.Application;
import static javafx.application.Application.launch;
import javafx.beans.binding.BooleanBinding;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.geometry.Insets;
import javafx.geometry.NodeOrientation;
import javafx.scene.Scene;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ButtonType;
import javafx.scene.control.Label;
import javafx.scene.control.Menu;
import javafx.scene.control.MenuBar;
import javafx.scene.control.MenuItem;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.HBox;
import javafx.stage.Stage;
import javafx.scene.layout.VBox;
import javafx.stage.FileChooser;

public class Exame extends Application {

    private Stage window;
    private TableView<Student> table;
    private FileChooser fileChooser;
    private FileChooser.ExtensionFilter filter;
    private File file;
    private FileWriter fileWriter;
    private MenuBar menuBar;
    private MenuItem load;
    private MenuItem save;
    private MenuItem exit;
    private Menu menu;
    private final ObservableList<Student> list = FXCollections.observableArrayList();
    private final TextField txtName = new TextField();
    private final TextField txtCourse = new TextField();
    private final TextField txtSemester = new TextField();
    private final TextField txtRegistration = new TextField();
    private final Label lblAdd = new Label("\n   Adicionar novo aluno:");
    private final Button btnAdd = new Button("Confirmar");
    private final Button btnDel = new Button("Deletar");
    private final Button btnEdit = new Button("Editar");
    TableColumn<Student, String> nameColumn = new TableColumn<>("Nome");
    TableColumn<Student, String> courseColumn = new TableColumn<>("Curso");
    TableColumn<Student, String> semesterColumn = new TableColumn<>("Semestre");
    TableColumn<Student, String> registrationColumn = new TableColumn<>("Matrícula");

    @Override
    public void start(Stage primaryStage) {

        window = primaryStage;
        window.setTitle("Teste - JavaFX");
        table = new TableView<>();
        menuBar = new MenuBar();
        load = new MenuItem("Load");
        save = new MenuItem("Save");
        exit = new MenuItem("Exit");
        menu = new Menu("File");
        btnAdd.setDisable(true);
        btnDel.setDisable(true);
        btnEdit.setDisable(true);

        //Columns
        //Name column
        nameColumn.setMinWidth(326);
        nameColumn.setCellValueFactory(new PropertyValueFactory<>("nome"));

        //Course column
        courseColumn.setMinWidth(300);
        courseColumn.setCellValueFactory(new PropertyValueFactory<>("curso"));

        //Semester column
        semesterColumn.setMinWidth(100);
        semesterColumn.setCellValueFactory(new PropertyValueFactory<>("semestre"));

        //Registration column
        registrationColumn.setMinWidth(100);
        registrationColumn.setCellValueFactory(new PropertyValueFactory<>("matricula"));

        //Adding the columns to the TableView
        table.getColumns().addAll(nameColumn, courseColumn, semesterColumn, registrationColumn);
        table.setItems(list);

        //Editing the TextField
        txtName.setMinWidth(250);
        txtName.setPromptText("Nome");

        txtCourse.setMinWidth(229);
        txtCourse.setPromptText("Curso");

        txtSemester.setMinWidth(150);
        txtSemester.setPromptText("Semestre");

        txtRegistration.setMinWidth(100);
        txtRegistration.setPromptText("Matrícula");

        //Buttons
        //Add Button
        BooleanBinding booleanBind = txtName.textProperty().isEmpty()
                .or(txtCourse.textProperty().isEmpty())
                .or(txtSemester.textProperty().isEmpty())
                .or(txtRegistration.textProperty().isEmpty());
        btnAdd.disableProperty().bind(booleanBind);
        btnAdd.setOnAction(e -> addButton());

        //Delete Button
        btnDel.setOnAction(e -> deleteButton());

        //Editing Button
        btnEdit.setOnAction(e -> editButton());

        //Putting the menu
        menu.getItems().addAll(load, save, exit);
        menuBar.getMenus().add(menu);

        //Setting the actions of the menu
        //EXIT
        exit.setOnAction((ActionEvent event) -> {
            window.close();
        });

        //LOAD
        load.setOnAction((ActionEvent event) -> {
            fileChooser = new FileChooser();
            file = fileChooser.showOpenDialog(window);
            String path = file.getPath();

            BufferedReader fileCSV;
            try {
                fileCSV = new BufferedReader(new FileReader(path));
                String line;
                while ((line = fileCSV.readLine()) != null) {
                    String[] cell = line.split(",", -1);
                    Student student = new Student(cell[0], cell[1], cell[2], cell[3]);
                    list.add(student);
                }
            } catch (FileNotFoundException ex) {
                System.out.println("Arquivo não encontrado.");
            } catch (IOException ex) {
                System.out.println("Ocorreu um erro!");
                Logger.getLogger(Exame.class.getName()).log(Level.SEVERE, null, ex);
            }
        });

        //SAVE
        save.setOnAction((ActionEvent event) -> {
            fileChooser = new FileChooser();
            filter = new FileChooser.ExtensionFilter("CSV File", "*.csv");
            fileChooser.getExtensionFilters().add(filter);
            file = fileChooser.showSaveDialog(window);

            ArrayList<String> cellsData = new ArrayList<>();

            for (Student item : table.getItems()) {

                cellsData.add(nameColumn.getCellObservableValue(item).getValue());
                cellsData.add(courseColumn.getCellObservableValue(item).getValue());
                cellsData.add(semesterColumn.getCellObservableValue(item).getValue());
                cellsData.add(registrationColumn.getCellObservableValue(item).getValue());
                cellsData.add("\n");

            }

            String data = cellsData.toString();
            data = formatingString(data);
            data = data.replace("[", "");
            data = data.replace("]", "");
            System.out.println(data);
            if (file != null) {
                try {
                    fileWriter = new FileWriter(file);
                    fileWriter.write(data);
                    fileWriter.close();
                } catch (IOException ex) {
                    Logger.getLogger(Exame.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        });

        table.setOnMouseClicked((MouseEvent event) -> {
            if (event.getClickCount() >= 1) {
                EnableButtons();
            }
        });

        VBox vBox = new VBox();
        HBox hBox = new HBox();
        HBox hBox2 = new HBox();

        hBox.setPadding(new Insets(10, 10, 10, 10));
        hBox.setSpacing(10);
        hBox.getChildren().addAll(txtName, txtCourse, txtSemester, txtRegistration);

        hBox2.setPadding(new Insets(10, 10, 10, 10));
        hBox2.setSpacing(10);
        hBox2.setNodeOrientation(NodeOrientation.RIGHT_TO_LEFT);
        hBox2.getChildren().addAll(btnAdd, btnDel, btnEdit);

        vBox.getChildren().addAll(menuBar, table, lblAdd, hBox, hBox2);

        Scene scene = new Scene(vBox);

        window.setScene(scene);
        window.show();

    }  //TERMINADO

    private void deleteButton() {
        ObservableList<Student> selectStudent, allStudents;
        allStudents = table.getItems();
        selectStudent = table.getSelectionModel().getSelectedItems();
        selectStudent.forEach(allStudents::remove);
        clearTextArea();
        lblAdd.setText("\n   Adicionar novo aluno:");
        btnDel.setDisable(true);
        btnEdit.setDisable(true);
    }  //TERMINADO

    private void addButton() {

        boolean flag = false;

        ArrayList<String> names = new ArrayList<>();
        for (Student item : table.getItems()) {
            names.add(nameColumn.getCellObservableValue(item).getValue());
        }
        ArrayList<String> registrations = new ArrayList<>();
        for (Student item : table.getItems()) {
            registrations.add(registrationColumn.getCellObservableValue(item).getValue());
        }

        for (int i = 0; i < names.size(); i++) {

            if (txtName.getText().equals(names.get(i)) || txtRegistration.getText().equals(registrations.get(i))) {
                Alert alert = new Alert(AlertType.CONFIRMATION);
                alert.setTitle("Aviso");
                alert.setHeaderText("Você está prestes a adicionar um aluno já existente.");
                alert.setContentText("Você está certo disso?");
                Optional<ButtonType> result = alert.showAndWait();
                if (result.get() == ButtonType.OK) {
                    addStudent();
                    clearTextArea();
                    flag = true;
                    btnDel.setDisable(true);
                    btnEdit.setDisable(true);
                    break;
                } else {
                    clearTextArea();
                    flag = true;
                    btnDel.setDisable(true);
                    btnEdit.setDisable(true);
                    break;
                }
            }
        }
        if (!flag) {
            addStudent();
        }

    }  //TERMINADO

    private void addStudent() {
        if (doesNotContainNumber(txtName.getText())) {
            Alert warning = new Alert(AlertType.WARNING);
            warning.setTitle("Warning");
            warning.setHeaderText("Preechimento incorreto do campo \"Nome\".");
            warning.setContentText("Por favor, insira apenas LETRAS.");
            warning.show();
            txtName.clear();
        } else if (doesNotContainNumber(txtCourse.getText())) {
            Alert warning = new Alert(AlertType.WARNING);
            warning.setTitle("Warning");
            warning.setHeaderText("Preechimento incorreto do campo \"Curso\".");
            warning.setContentText("Por favor, insira apenas LETRAS.");
            warning.show();
            txtCourse.clear();
        } else if (onlyContainNumber(txtSemester.getText())) {
            Alert warning = new Alert(AlertType.WARNING);
            warning.setTitle("Warning");
            warning.setHeaderText("Preechimento incorreto do campo \"Semestre\".");
            warning.setContentText("Por favor, insira apenas NÚMEROS.");
            warning.show();
            txtSemester.clear();
        } else if (onlyContainNumber(txtRegistration.getText())) {
            Alert warning = new Alert(AlertType.WARNING);
            warning.setTitle("Warning");
            warning.setHeaderText("Preechimento incorreto do campo \"Matrícula\".");
            warning.setContentText("Por favor, insira apenas NÚMEROS.");
            warning.show();
            txtRegistration.clear();
        } else {
            list.add(new Student(txtName.getText(), txtCourse.getText(), txtSemester.getText(), txtRegistration.getText()));
            clearTextArea();
        }

    }  //TERMINADO

    private void clearTextArea() {
        txtName.clear();
        txtCourse.clear();
        txtSemester.clear();
        txtRegistration.clear();
    }  //TERMINADO

    private void editButton() {
        int index = table.getSelectionModel().getSelectedIndex();
        Student student = table.getSelectionModel().getSelectedItem();
        table.getItems().remove(index);
        addButton();
        clearTextArea();
        btnDel.setDisable(true);
        btnEdit.setDisable(true);
    }  //TERMINADO

    public void EnableButtons() {
        if (table.getSelectionModel().getSelectedItem() != null) {
            Student selectedStudent = table.getSelectionModel().getSelectedItem();
            txtName.setText(selectedStudent.getNome());
            txtCourse.setText(selectedStudent.getCurso());
            txtSemester.setText(selectedStudent.getSemestre());
            txtRegistration.setText(selectedStudent.getMatricula());
        }

        lblAdd.setText("\n   Editar Aluno");
        btnDel.setDisable(false);
        btnEdit.setDisable(false);
    }  //TERMINADO

    private void readCSVFile(String CSVFile) {

        BufferedReader fileCSV;
        try {
            fileCSV = new BufferedReader(new FileReader(CSVFile));
            String line;
            while ((line = fileCSV.readLine()) != null) {
                String[] cell = line.split(",", 4);
                Student student = new Student(cell[0], cell[1], cell[2], cell[3]);
                list.add(student);
            }
        } catch (FileNotFoundException ex) {
            System.out.println("Arquivo não encontrado.");
        } catch (IOException ex) {
            Logger.getLogger(Exame.class.getName()).log(Level.SEVERE, null, ex);
        }

    }  //TERMINADO

    public String formatingString(String str) {
        String string = null;

        for (int i = 1; i < str.length(); i++) {
            if (str.charAt(i - 1) == '\n' || str.charAt(i + 1) == '\n') {

            } else {
                char c = str.charAt(i);
                string += c;
            }
        }
        String data = string.replaceFirst("null", "");

        return data;
    }  //TERMINADO

    public final boolean doesNotContainNumber(String str) {
        boolean containsDigit = false;

        if (str != null && !str.isEmpty()) {
            for (char c : str.toCharArray()) {
                if (containsDigit = Character.isDigit(c)) {
                    break;
                }
            }
        }
        return containsDigit;
    }  //TERMINADO

    public final boolean onlyContainNumber(String str) {
        boolean containsDigit = false;

        if (str != null && !str.isEmpty()) {
            for (char c : str.toCharArray()) {
                if (containsDigit = Character.isAlphabetic(c)) {
                    break;
                }
            }
        }
        return containsDigit;
    }  //TERMINADO
    
    public static void main(String[] args) {
        launch(args);
    }  //MAIN

}
